# PostgreSQL HA Example

## Getting Started

```shell
vagrant up
vagrant ssh manager
cd /vagrant
sudo ./docker_manager_setup.sh
sudo docker stack deploy --compose-file docker-compose.yml pg_example
exit
```

This will start four VMs:
```text
   host        labels.pg_role
-----------------------------
1. manager     -
2. worker1     pg_primary
3. worker2     pg_standby_1
4. worker3     pg_standby_2
```

## Test standby node downtime

Create `users` table on `primary` node

```sql
-- postgresql://192.168.50.101:5432/postgres

CREATE TABLE IF NOT EXISTS users (
    email   VARCHAR(255)
);

INSERT INTO users VALUES ('john@example.com');

SELECT * FROM users;
```

List `users` table on `standby_1` node

```sql
-- postgresql://192.168.50.102:5433/postgres

SELECT * FROM users;
```

List `users` table on `standby_2` node

```sql
-- postgresql://192.168.50.103:5434/postgres

SELECT * FROM users;
```

Shut down `standby_1` node

```shell
vagrant halt worker2
```

Add a new `users` record on `primary` node

```sql
-- postgresql://192.168.50.101:5432/postgres

INSERT INTO users VALUES ('kate@example.com');

SELECT * FROM users;
```

Start `standby_1 node`

```shell
vagrant up worker2
```

Check that `users` table is up-to-date on `standby_1` node

```sql
-- postgresql://192.168.50.102:5433/postgres

SELECT * FROM users;
```

## Test primary node downtime

Shut down `primary` node

```shell
vagrant halt worker1
```

Add a new `users` record on `standby_1` node

```sql
-- postgresql://192.168.50.102:5433/postgres

INSERT INTO users VALUES ('mary@example.com');

SELECT * FROM users;
```

Start `primary node`

```shell
vagrant up worker1
```

Check that `users` table is up-to-date on `primary` node

```sql
-- postgresql://192.168.50.101:5432/postgres

SELECT * FROM users;
```
