# Testing schema caching in Rails production

if you need to drop an existing "production" database
```
RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bin/rails db:drop
```

Set up new "production" database with 3 Foos and 3 Bars

```
RAILS_ENV=production bin/rails db:create db:migrate db:seed`
```

Precompile assets a la prod
``` 
RAILS_ENV=production bin/rails assets:precompile
```

Start a "production" server
```
RAILS_ENV=production bin/rails s
```

Go to
- http://0.0.0.0/foos
- http://0.0.0.0/bars

Both should load correctly

To simulate dropping a column during a production migration, keep the rails server running and run psql
```
RAILS_ENV=production bin/rails dbconsole
```

```
schema_cache_test_production=# ALTER TABLE foos DROP COLUMN x;
```

Now reload

- http://0.0.0.0/foos
- http://0.0.0.0/bars

/foos will fail because it makes a direct reference to the dropped column `x`
however /bars, which still does a `Foo.all` will succeed. But if you look at the column names, `x` will still be there since the application hasn't restarted to pick up the schema changes from postgres.
