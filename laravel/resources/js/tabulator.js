import xlsx from "xlsx";
import { createIcons, icons } from "lucide";
import axios from "axios";
import Tabulator from "tabulator-tables";
import { min } from "lodash";

(function () {
    "use strict";

    // Tabulator Log Error
    if ($("#tabulator").length) {
        // Setup Tabulator
        let table = new Tabulator("#tabulator", {
            ajaxURL: "/log-error/data",
            printAsHtml: true,
            printStyled: true,
            pagination: "remote",
            paginationSize: 10,
            paginationSizeSelector: [10, 20, 30, 40],
            layout: "fitColumns",
            responsiveLayout: "collapse",
            placeholder: "No matching records found",
            columns: [
                {
                    formatter: "responsiveCollapse",
                    width: 40,
                    minWidth: 30,
                    hozAlign: "center",
                    resizable: false,
                    headerSort: false,
                },

                // For HTML table
                {
                    title: "DATETIME",
                    width: 160,
                    responsive: 0,
                    field: "datetime",
                    vertAlign: "middle",
                    print: false,
                    download: false,
                },
                {
                    title: "LEVEL",
                    width: 115,
                    field: "level",
                    hozAlign: "center",
                    vertAlign: "middle",
                    print: false,
                    download: false,
                    formatter(cell, formatterParams) {
                        let level = cell.getValue().toUpperCase();
                        let id = cell.getData().id;
                        let colorClass = "text-slate-500";
                        switch (level) {
                            case "ERROR":
                            case "CRITICAL":
                                colorClass = "text-danger";
                                break;
                            case "WARNING":
                                colorClass = "text-warning";
                                break;
                            case "INFO":
                                colorClass = "text-primary";
                                break;
                            case "DEBUG":
                                colorClass = "text-slate-500";
                                break;
                        }
                        return `<div class="flex items-center lg:justify-center ${colorClass}">
                            <span class="font-medium">${level}</span>
                        </div>`;
                    },
                },
                {
                    title: "MESSAGE",
                    minWidth: 200,
                    field: "message",
                    vertAlign: "top",
                    formatter: "textarea",
                    print: false,
                    download: false,
                },
                {
                    title: "ACT",
                    width: 100,
                    field: "actions",
                    responsive: 1,
                    hozAlign: "center",
                    vertAlign: "middle",
                    print: false,
                    download: false,
                    formatter: function(cell) {
                        // Formatter should only return a simple HTML string.
                        // Event handling will be done via delegation.
                        const hasStackTrace = cell.getData().stack_trace;
                        if (!hasStackTrace) {
                            return ""; // Tidak ada tombol jika tidak ada stack trace
                        }
                        return `<a class="flex items-center text-primary whitespace-nowrap btn-view-log" href="javascript:;">
                                    <i data-lucide="eye" class="w-4 h-4 mr-1"></i> Detail
                                </a>`;
                    },
                },

                // For print format
                {
                    title: "DATETIME",
                    field: "datetime",
                    visible: false,
                    print: true,
                    download: true,
                },
                {
                    title: "LEVEL",
                    field: "level",
                    visible: false,
                    print: true,
                    download: true,
                },
                {
                    title: "MESSAGE",
                    field: "message",
                    visible: false,
                    print: true,
                    download: true,
                },
            ],
            renderComplete() {
                createIcons({
                    icons,
                    "stroke-width": 1.5,
                    nameAttr: "data-lucide",
                });
            },
        });

        // Event Delegation for "View Log" button
        // This is the correct way to handle events for elements created by a formatter.
        $("#tabulator").on("click", ".btn-view-log", function() {
            // Find the cell component for the button that was clicked
            const cell = $(this).closest(".tabulator-cell").data("cell");
            if (cell) {
                const rowData = cell.getData();
                const stackTrace = rowData.stack_trace;

                $("#log-error-modal-content").html(`<pre class="whitespace-pre-wrap break-words">${stackTrace}</pre>`);
                const modal = tailwind.Modal.getOrCreateInstance(document.querySelector("#log-error-modal"));
                modal.show();
            }
        });

        // Redraw table onresize
        window.addEventListener("resize", () => {
            table.redraw();
            createIcons({
                icons,
                "stroke-width": 1.5,
                nameAttr: "data-lucide",
            });
        });

        // Filter function
        function filterHTMLForm() {
            let field = $("#tabulator-html-filter-field").val();
            let type = $("#tabulator-html-filter-type").val();
            let value = $("#tabulator-html-filter-value").val();
            table.setFilter(field, type, value);
        }

        // On submit filter form
        $("#tabulator-html-filter-form")[0].addEventListener(
            "keypress",
            function (event) {
                let keycode = event.keyCode ? event.keyCode : event.which;
                if (keycode == "13") {
                    event.preventDefault();
                    filterHTMLForm();
                }
            }
        );

        // On click go button
        $("#tabulator-html-filter-go").on("click", function (event) {
            filterHTMLForm();
        });

        // On reset filter form
        $("#tabulator-html-filter-reset").on("click", function (event) {
            $("#tabulator-html-filter-field").val("datetime");
            $("#tabulator-html-filter-type").val("like");
            $("#tabulator-html-filter-value").val("");
            filterHTMLForm();
        });

        // Export
        $("#tabulator-export-csv").on("click", function (event) {
            table.download("csv", "data.csv");
        });

        $("#tabulator-export-json").on("click", function (event) {
            table.download("json", "data.json");
        });

        $("#tabulator-export-xlsx").on("click", function (event) {
            window.XLSX = xlsx;
            table.download("xlsx", "data.xlsx", {
                sheetName: "Products",
            });
        });

        $("#tabulator-export-html").on("click", function (event) {
            table.download("html", "data.html", {
                style: true,
            });
        });

        // Print
        $("#tabulator-print").on("click", function (event) {
            table.print();
        });

        // On click clear log button
        $("#clear-log-button").on("click", function (event) {
            if (confirm("Are you sure you want to clear the log file? This action cannot be undone.")) {
                axios.delete('/log-error/clear', {
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    }
                }).then(response => {
                    alert(response.data.message);
                    // Reload the table data
                    table.setData();
                }).catch(error => {

                    if (error.response) {
                        alert("Error ID: " + (error.response.data.error_id || "Could not clear log file."));
                    } else {
                        alert("An unexpected error occurred.");
                    }
                    console.error("Error clearing log:", error);
                });
            }
        });
    }

    // Tabulator User Management
    if ($("#tbl-user").length) {
        // Setup Tabulator
        let table = new Tabulator("#tbl-user", {
            ajaxURL: "/user/data",
            printAsHtml: true,
            printStyled: true,
            pagination: "local",
            paginationSize: 10,
            paginationSizeSelector: [10, 20, 30, 40],
            layout: "fitColumns",
            responsiveLayout: "collapse",
            placeholder: "No matching records found",
            columns: [
                {
                    formatter: "responsiveCollapse",
                    width: 40,
                    minWidth: 30,
                    hozAlign: "center",
                    resizable: false,
                    headerSort: false,
                },

                // For HTML table
                { title: "NAME", field: "name", hozAlign: "left", minWidth: 200 },
                { title: "EMAIL", field: "email", hozAlign: "left", minWidth: 200 },
                { title: "UNIT", field: "unit", hozAlign: "left", minWidth: 150 },
                { title: "ROLE", field: "role", hozAlign: "left", minWidth: 150 },
                {
                    title: "ACTIONS",
                    field: "id",
                    hozAlign: "center",
                    headerSort: false,
                    width: 120,
                    formatter: function (cell, formatterParams, onRendered) {
                        let id = cell.getValue();
                        return `
                            <div class="flex lg:justify-center items-center">
                                <a class="flex items-center mr-3 btn-edit" href="javascript:;" data-id="${id}">
                                    <i data-lucide="check-square" class="w-4 h-4 mr-1"></i> Edit
                                </a>
                                <a class="flex items-center text-danger btn-delete" href="javascript:;" data-id="${id}">
                                    <i data-lucide="trash-2" class="w-4 h-4 mr-1"></i> Delete
                                </a>
                            </div>
                        `;
                    },
                },
            ],
            renderComplete() {
                createIcons({
                    icons,
                    "stroke-width": 1.5,
                    nameAttr: "data-lucide",
                });
            },
        });

        // Redraw table onresize
        window.addEventListener("resize", () => {
            table.redraw();
            createIcons({
                icons,
                "stroke-width": 1.5,
                nameAttr: "data-lucide",
            });
        });

        // Filter function
        function filterHTMLForm() {
            let field = $("#tabulator-html-filter-field").val();
            let type = $("#tabulator-html-filter-type").val();
            let value = $("#tabulator-html-filter-value").val();
            table.setFilter(field, type, value);
        }

        // On submit filter form
        $("#tabulator-html-filter-form")[0].addEventListener(
            "keypress",
            function (event) {
                let keycode = event.keyCode ? event.keyCode : event.which;
                if (keycode == "13") {
                    event.preventDefault();
                    filterHTMLForm();
                }
            }
        );

        // On click go button
        $("#tabulator-html-filter-go").on("click", function (event) {
            filterHTMLForm();
        });

        // On reset filter form
        $("#tabulator-html-filter-reset").on("click", function (event) {
            $("#tabulator-html-filter-field").val("name");
            $("#tabulator-html-filter-type").val("like");
            $("#tabulator-html-filter-value").val("");
            filterHTMLForm();
        });

        // Export
        $("#tabulator-export-csv").on("click", function (event) {
            table.download("csv", "data.csv");
        });

        $("#tabulator-export-json").on("click", function (event) {
            table.download("json", "data.json");
        });

        $("#tabulator-export-xlsx").on("click", function (event) {
            window.XLSX = xlsx;
            table.download("xlsx", "data.xlsx", {
                sheetName: "Products",
            });
        });

        $("#tabulator-export-html").on("click", function (event) {
            table.download("html", "data.html", {
                style: true,
            });
        });

        // Print
        $("#tabulator-print").on("click", function (event) {
            table.print();
        });

        // === CRUD Operations ===
        const userModal = tailwind.Modal.getOrCreateInstance(document.querySelector("#user-modal"));
        const userForm = document.querySelector("#user-form");

        // Function to reset form and errors
        function resetForm() {
            userForm.reset();
            $('#user_id').val('');
            $('#password-hint').addClass('hidden');
            $('.text-danger').html('');
        }

        // Function to populate roles dropdown
        async function populateRoles() {
            try {
                const response = await axios.get(`/users/roles`);
                const roles = response.data;
                const roleSelect = document.querySelector('#role');
                roleSelect.innerHTML = ''; // Clear existing options
                roles.forEach(role => {
                    roleSelect.add(new Option(role, role));
                });
            } catch (error) {
                console.error('Failed to fetch roles:', error);
            }
        }

        // Show "Add User" modal
        $('#btn-add-user').on('click', function() {
            resetForm();
            $('#user-modal-title').html('Add User');
            $('#password').attr('required', true);
            $('#password-hint').addClass('hidden');
            populateRoles();
            userModal.show();
            // Force re-render of icons after modal is shown, as it can cause a table redraw.
            createIcons({
                icons,
                "stroke-width": 1.5,
                nameAttr: "data-lucide",
            });
        });

        // Show "Edit User" modal
        $('#tbl-user').on('click', '.btn-edit', async function() {
            resetForm();
            let userId = $(this).data('id');
            $('#user-modal-title').html('Edit User');
            $('#password').removeAttr('required');
            $('#password-hint').removeClass('hidden');

            try {
                const response = await axios.get(`/users/${userId}`);
                const user = response.data;
                $('#user_id').val(user.id);
                $('#name').val(user.name);
                $('#email').val(user.email);
                $('#unit').val(user.unit);

                await populateRoles(); // Ensure roles are loaded before setting value
                if (user.roles && user.roles.length > 0) {
                    $('#role').val(user.roles[0].name);
                }

                userModal.show();
            } catch (error) {
                console.error('Failed to fetch user data:', error);
                alert('Could not load user data.');
            }
        });

        // Handle form submission (Create & Update)
        $('#user-form').on('submit', async function(e) {
            console.log('Submitting form...');
            e.preventDefault();
            $('.text-danger').html(''); // Clear previous errors

            const formData = new FormData(this);
            const userId = $('#user_id').val();
            let url = userId ? `/users/${userId}` : $(this).data('store-url');
            let method = userId ? 'POST' : 'POST'; // Use POST with _method for PUT

            if (userId) {
                formData.append('_method', 'PUT');
            }

            try {
                const response = await axios.post(url, formData);
                userModal.hide();
                // Refresh table and re-render icons after data is replaced
                table.replaceData().then(() => {
                    createIcons({
                        icons,
                        "stroke-width": 1.5,
                        nameAttr: "data-lucide",
                    });
                });
                // Show success notification (optional, using a library like Toastify)
                alert(response.data.message);
            } catch (error) {
                if (error.response && error.response.status === 422) {
                    // Validation errors
                    const errors = error.response.data.errors;
                    for (const key in errors) {
                        $(`#error-${key}`).html(errors[key][0]);
                    }
                } else {
                    console.error('An error occurred:', error);
                    alert('An unexpected error occurred. Please try again.');
                }
            }
        });

        // Handle "Delete" button click
        $('#tbl-user').on('click', '.btn-delete', async function() {
            let userId = $(this).data('id');
            if (confirm('Are you sure you want to delete this user?')) {
                try {
                    const response = await axios.delete(`/users/${userId}`);
                    // Refresh table and re-render icons after data is replaced
                    table.replaceData().then(() => {
                        createIcons({
                            icons,
                            "stroke-width": 1.5,
                            nameAttr: "data-lucide",
                        });
                    });
                    alert(response.data.message);
                } catch (error) {
                    console.error('Deletion failed:', error);
                    alert(error.response.data.message || 'Failed to delete user.');
                }
            }
        });
    }
})();
