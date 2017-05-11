init_pgpass() {
  echo 'Exporting PGPASSFILE and setting permissions to 0600'
  export PGPASSFILE="{{pkg.svc_config_path}}/.pgpass"
  chmod 0600 {{pkg.svc_config_path}}/.pgpass
}

fix_dir_ownership() {
  echo 'Making sure hab user owns var, config and data paths'
  chown -R hab:hab {{pkg.svc_var_path}}
  chown -R hab:hab {{pkg.svc_config_path}}
  chown -R hab:hab {{pkg.svc_data_path}}
}

write_env_var() {
  echo "$1" > "{{pkg.svc_config_path}}/env/$2"
}

write_wale_env() {
  echo 'Writting environment variables required by wal-e'
  mkdir -p "{{pkg.svc_config_path}}/env"
  {{#with cfg.wal-e.aws }}
  write_env_var 's3://{{bucket}}/{{../../../svc.service}}-{{../../../svc.group}}' 'WALE_S3_PREFIX'
  write_env_var '{{access_key_id}}' 'AWS_ACCESS_KEY_ID'
  write_env_var '{{secret_access_key}}' 'AWS_SECRET_ACCESS_KEY'
  write_env_var '{{region}}' 'AWS_REGION'
  {{/with}}

  write_env_var '{{cfg.superuser.name}}' 'PGUSER'
  write_env_var '{{cfg.superuser.password}}' 'PGPASSWORD'
  write_env_var 'postgres' 'PGDATABASE'
}

setup_replication_user_in_master() {
  echo 'Making sure replication role exists on Master'
  psql -U {{cfg.superuser.password}}  -h {{svc.leader.sys.ip}} -p {{cfg.port}} postgres >/dev/null 2>&1 << EOF
DO \$$
  BEGIN
  PERFORM * FROM pg_authid WHERE rolname = '{{cfg.replication.name}}';
  IF FOUND THEN
    ALTER ROLE "{{cfg.replication.name}}" WITH REPLICATION LOGIN PASSWORD '{{cfg.replication.password}}';
  ELSE
    CREATE ROLE "{{cfg.replication.name}}" WITH REPLICATION LOGIN PASSWORD '{{cfg.replication.password}}';
  END IF;
END;
\$$
EOF
}
