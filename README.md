# El Mono App: Store Management System

> A full-stack management system for **El Mono**, a neighbourhood store in Villavicencio, Colombia. It automates inventory, sales, purchases, expenses and customer and supplier records on a relational MySQL database designed from scratch.

![React](https://img.shields.io/badge/React-20232A?logo=react&logoColor=61DAFB)
![Node.js](https://img.shields.io/badge/Node.js-339933?logo=nodedotjs&logoColor=white)
![Express](https://img.shields.io/badge/Express-000000?logo=express&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?logo=mysql&logoColor=white)
![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-06B6D4?logo=tailwindcss&logoColor=white)

Final project for *Bases de Datos* (Databases), Universidad Nacional de Colombia.

## Overview

Small stores often track stock, sales and expenses by hand. El Mono App replaces that with a role-based web interface on top of a normalised MySQL database:

- **Store clerk (tendero):** browse products in stock and register sales and invoices.
- **Manager (gerente):** register purchases from suppliers and business expenses, and review sales invoices, inventory, customers and suppliers.

## Database design

The database (`BD_Proyecto_Tienda`) is the core of the project. All scripts are in [`MYSQL-SCRIPTS/`](MYSQL-SCRIPTS/).

| Layer | What's included |
|---|---|
| **Schema** | 18 tables: customers, branches, employees & schedules, store products & batches (`LOTE`), sales / purchase / expense invoices with line items, suppliers, payment methods (bank and mobile transfers) |
| **Views** | Products in stock, current inventory, inventory entries and exits, opening balance, registered sales invoices, customers, suppliers, expense products |
| **Stored procedures** | Register sales, purchases, expenses and their line items; register customers; update delivery status and payment method; assign employee schedules |
| **Functions** | Invoice totals, total sales and invoice count per period, average invoice value |
| **Triggers** | Audit log of deleted sales and purchase invoices and their line items |
| **Security** | Roles and permissions for `gerente`, `tendero` and `domiciliario` (delivery) |
| **Performance** | Indexes on frequent query paths |
| **Data** | Seed data, sample queries, update and delete scripts |

## Architecture

```
React (Formik + Yup forms, React Router, Tailwind)  ──axios──▶  Express API (server.js, :3001)  ──▶  MySQL views & procedures
```

REST endpoints include `/api/productos`, `/api/productosfactura`, `/api/clientes`, `/api/proveedor`, `/api/productosgasto` and `/api/facturasventas`.

## Getting started

**Prerequisites:** Node.js 18+ and MySQL 8.

1. Create the database by running the scripts in `MYSQL-SCRIPTS/` in this order: creation → data insertion → views → procedures & functions → triggers → indexes → users & roles.
2. Set your MySQL credentials in `server.js`.
3. Install the dependencies and start both servers:
   ```bash
   npm install
   node server.js      # API on http://localhost:3001
   npm start           # UI on http://localhost:3000
   ```

## Project structure

```
├── MYSQL-SCRIPTS/     # schema, views, procedures, functions, triggers, indexes, roles, seed data
├── server.js          # Express REST API over MySQL
├── src/
│   ├── components/    # layout and role-specific menus (manager / clerk)
│   └── pages/         # products, sales, purchases, expenses, invoices
└── public/
```

## Team

- **Laura Nicole Bermúdez Santa** · [@bermudez05](https://github.com/bermudez05)
- **Nicolás Álvarez Triana** · [@niclasDc](https://github.com/niclasDc)
