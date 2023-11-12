# ShopHere Project: Retail Business Management Database

## Overview
"ShopHere Project" is a comprehensive database system tailored for retail business management. It encompasses employee tracking, product categories, supplier details, inventory management, and order processing, equipped with efficient triggers and constraints for streamlined retail operations.

## Database Structure

### Tables
- **Employee**: Maintains employee details, including name, city, and phone number.
- **ProductCategory**: Holds information about product categories, enforcing constraints on category names.
- **SupplierDetails**: Contains comprehensive details of suppliers.
- **ItemDetails**: Manages inventory items, pricing, quantities, reorder levels, and relationships.
- **OrderDetails**: Tracks purchase orders, including dates, quantities, and order status.

### Triggers and Constraints
- **Tri_OrderDetails_QuantityinHand**: Updates inventory quantities in `ItemDetails` based on new orders.
- Check constraints across tables to ensure data accuracy, like valid phone number formats and status validations.

### ER Diagram
An ER diagram is included to visualize the database structure and entity relationships.

## Technical Requirements
- SQL Server 2019 or later.
- SQL Server Management Studio (SSMS) for database setup and management.

## Setup and Usage
1. Install SQL Server 2019 and SSMS.
2. Run the provided SQL script in SSMS to create and populate the database.
3. Refer to the ER diagram to understand the database schema.

## Usage Scenarios
- **Inventory Management**: Efficiently manage inventory levels and supplier relationships.
- **Order Processing**: Handle customer orders from placement to delivery, including shipping and status tracking.
- **Employee Management**: Maintain comprehensive employee records and manage roles.

## Customization
- Adaptable to specific retail types such as clothing, electronics, or grocery stores.
- Extensible with additional tables and fields for unique business needs.

## Contribution
- Contributions to enhance or adapt the database are welcome.
- Follow standard SQL practices and document significant changes.
- Use GitHub Pull Requests for submissions, ensuring code is well-tested.

## License
This project is open-sourced under the MIT License. See the `LICENSE` file for more details.
