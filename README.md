Welcome to DBT project

# 📦 dwh_northwind  
### **Analytical Data Warehouse built from the Northwind OLTP database using dbt + PostgreSQL**

This project implements a complete **modern data warehouse** using:

- **dbt (Data Build Tool)** for transformation, testing, documentation  
- **PostgreSQL** as the analytical warehouse  
- **Northwind OLTP** as the source system  
- A clean **staging → intermediate → marts** architecture  
- Automated **schema grants** via dbt hooks  
- Full **documentation** and **lineage graph** via `dbt docs`

The goal is to demonstrate best practices in **data modeling**, **ELT pipelines**, **data quality**, and **analytics engineering**.

---

## 🏗️ Project Architecture

The project follows a classic **layered DWH architecture**:

```
Northwind OLTP
      ↓
Staging (stg_)
      ↓
Intermediate (int_)
      ↓
Marts (dim_ / fact_)
```

### **1. Staging Layer (`models/staging/`)**
- One model per source table  
- Light transformations  
- Column renaming  
- Type normalization  
- Surrogate keys when needed  

### **2. Intermediate Layer (`models/intermediate/`)**
- Business logic  
- Joins  
- Enrichments  
- Deduplication  
- Pre‑aggregation  

### **3. Marts Layer (`models/marts/`)**
- Star schema  
- Dimensions: `dim_customers`, `dim_employees`, `dim_products`, `dim_shippers`, `dim_temps`  
- Fact table: `fact_orders`  
- Optimized for BI tools and analytics  

---

## 🗂️ Repository Structure

```
dwh_northwind/
│
├── models/
│   ├── staging/
│   ├── intermediate/
│   └── marts/
│
├── macros/
│
├── tests/
│
├── analyses/
│
├── seeds/
│
├── snapshots/
│
└── dbt_project.yml
```

---

## ⚙️ dbt Configuration Highlights

### **Materialization Strategy**
- `staging`: **view**
- `intermediate`: **view**
- `marts`: **table**

### **Post‑run Grants (Security Layer)**  
Automatically applied after each dbt run:

```yaml
models:
  on_run_end:
    - "GRANT USAGE ON SCHEMA {{ target.schema }} TO dwh_northwind_readonly"
    - "GRANT SELECT ON ALL TABLES IN SCHEMA {{ target.schema }} TO dwh_northwind_readonly"
    - "GRANT USAGE ON SCHEMA {{ target.schema }} TO DWH_dbt_project"
    - "GRANT SELECT ON ALL TABLES IN SCHEMA {{ target.schema }} TO DWH_dbt_project"
```

This ensures **read‑only access** for BI users and **full access** for the dbt service role.

---

## 🔍 Data Quality & Testing

The project uses dbt tests:

- **Uniqueness tests** on primary keys  
- **Not null tests** on key business fields  
- **Relationship tests** between fact and dimensions  
- **Custom tests** when needed  

Example:

```yaml
columns:
  - name: customer_id
    tests:
      - not_null
      - unique
```

---

## 📊 Documentation & Lineage

Generate documentation:

```
dbt docs generate
```

Serve documentation locally:

```
dbt docs serve
```

This provides:

- Column descriptions  
- Model documentation  
- Tests  
- Lineage graph  
- DAG visualization  

---

## 🚀 How to Run the Project

### **1. Create virtual environment**
```
python -m venv venv
source venv/bin/activate   # macOS/Linux
venv\Scripts\activate      # Windows
```

### **2. Install dependencies**
```
pip install dbt-postgres
```

### **3. Configure your `profiles.yml`**
Example:

```yaml
DWH_dbt_project:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      user: postgres
      password: zawl
      dbname: northwind_dwh
      schema: analytics
      threads: 4
```

### **4. Run dbt**
```
dbt debug
dbt run
dbt test
dbt docs serve
```

---

## 📈 Final Deliverables

- Fully functional **analytical DWH**  
- Clean **star schema**  
- Automated **grants**  
- Complete **documentation**  
- Reusable **macros**  
- Strong **data quality tests**  
- Professional **project structure**  

---

## 👤 Author

**Tesfabirhan Redie**  
Data Engineer & Analytics Engineer  
Bourg‑en‑Bresse, France  
