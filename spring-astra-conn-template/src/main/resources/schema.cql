 CREATE TABLE IF NOT EXISTS my_table (id uuid, field1 text, field2 text, PRIMARY KEY ((id)));
 CREATE INDEX IF NOT EXISTS my_table_field1 ON my_table (field1);