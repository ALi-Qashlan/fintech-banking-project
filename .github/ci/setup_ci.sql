drop schema if exists raw cascade;

create schema raw;


create table raw.customers (
    customer_id varchar(20) primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100),
    city varchar(50),
    credit_score int,
    created_at timestamp
);


create table raw.accounts (
    account_id varchar(20) primary key,
    customer_id varchar(20),
    account_type varchar(20),
    balance_usd decimal(12,2),
    open_date date,

    foreign key (customer_id)
        references raw.customers(customer_id)
);


create table raw.cards (
    card_id varchar(20) primary key,
    account_id varchar(20),
    card_type varchar(20),
    expiration_date date,

    foreign key (account_id)
        references raw.accounts(account_id)
);


create table raw.loans (
    loan_id varchar(20) primary key,
    customer_id varchar(20),
    loan_amount decimal(12,2),
    interest_rate decimal(5,2),
    start_date date,

    foreign key (customer_id)
        references raw.customers(customer_id)
);


create table raw.merchants (
    merchant_id varchar(20) primary key,
    merchant_name varchar(100),
    city varchar(50)
);


create table raw.branches (
    branch_id varchar(20) primary key,
    branch_name varchar(100),
    manager_name varchar(100),
    city varchar(50),
    country varchar(50)
);


create table raw.transactions (
    transaction_id varchar(20) primary key,
    account_id varchar(20),
    merchant_id varchar(20),
    amount_usd decimal(12,2),
    transaction_date timestamp,

    foreign key (account_id)
        references raw.accounts(account_id),

    foreign key (merchant_id)
        references raw.merchants(merchant_id)
);


insert into raw.customers values
    ('CUST001', 'Alice', 'Hassan', 'alice@example.com', 'Cairo', 720, '2020-01-01'),
    ('CUST002', 'Omar', 'Ali', 'omar@example.com', 'Mansoura', 610, '2021-01-01'),
    ('CUST003', 'Sara', 'Ahmed', 'sara@example.com', 'Alexandria', 500, '2022-01-01'),
    ('CUST004', 'Nada', 'Mahmoud', 'nada@example.com', 'Giza', 800, '2024-01-01');


insert into raw.accounts values
    ('ACC001', 'CUST001', 'Checking', 10000.00, '2020-01-15'),
    ('ACC002', 'CUST001', 'Savings', 5000.00, '2020-04-01'),
    ('ACC003', 'CUST002', 'Business', 20000.00, '2021-02-01'),
    ('ACC004', 'CUST003', 'Checking', 2500.00, '2022-03-01');


insert into raw.cards values
    ('CARD001', 'ACC001', 'Debit', '2028-01-01'),
    ('CARD002', 'ACC002', 'Credit', '2029-01-01'),
    ('CARD003', 'ACC003', 'Debit', '2028-06-01');


insert into raw.loans values
    ('LOAN001', 'CUST001', 50000.00, 5.25, '2021-01-01'),
    ('LOAN002', 'CUST002', 120000.00, 7.50, '2022-01-01'),
    ('LOAN003', 'CUST003', 175000.00, 9.00, '2023-01-01');


insert into raw.merchants values
    ('MER001', 'Fresh Market', 'Cairo'),
    ('MER002', 'Tech Store', 'Mansoura'),
    ('MER003', 'Travel Hub', 'Alexandria'),
    ('MER004', 'Inactive Merchant', 'Giza');


insert into raw.branches values
    ('BR001', 'Cairo Central', 'Ahmed Hassan', 'Cairo', 'Egypt'),
    ('BR002', 'Mansoura Central', 'Mona Ali', 'Mansoura', 'Egypt');


insert into raw.transactions values
    ('TX001', 'ACC001', 'MER001', 100.00, '2025-01-15 10:00:00'),

    ('TX002', 'ACC001', 'MER001', 100.00, '2025-04-10 10:00:00'),
    ('TX003', 'ACC001', 'MER002', 150.00, '2025-05-12 11:00:00'),

    ('TX004', 'ACC001', 'MER001', 100.00, '2025-07-05 10:00:00'),
    ('TX005', 'ACC001', 'MER002', 150.00, '2025-08-05 11:00:00'),
    ('TX006', 'ACC001', 'MER003', 200.00, '2025-09-05 12:00:00'),

    ('TX007', 'ACC001', 'MER001', 100.00, '2025-10-05 10:00:00'),
    ('TX008', 'ACC001', 'MER002', 150.00, '2025-11-05 11:00:00'),
    ('TX009', 'ACC001', 'MER003', 200.00, '2025-11-20 12:00:00'),
    ('TX010', 'ACC001', 'MER001', 250.00, '2025-12-05 13:00:00'),

    ('TX011', 'ACC003', 'MER002', 400.00, '2025-12-10 14:00:00');