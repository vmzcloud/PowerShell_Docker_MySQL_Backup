# Windows Docker MySQL backup powershell script

$db_username="db_user"
$db_password="db_password"

$container_name="container1"

$backup_db1="db1"
$backup_db2="db2"
$backup_db3="db3"

$backup_date = Get-Date -Format "yyyyMMdd"
$backup_location="/var/lib/mysql/backup/$backup_date/"

$docker_volume_bk_folder="D:\DockerVol\MySQL\data\backup\$backup_date"
$Backup_folder="D:\MySQL\Backup\"


# Create backup folder
docker exec -it $container_name bash -c "mkdir -p $backup_location"

# MySQLDump Start
docker exec -it $container_name bash -c "/usr/bin/mysqldump -u $db_username -p$db_password $backup_db1 --routines > $($backup_location)$($backup_db1)_$($backup_date).sql"
docker exec -it $container_name bash -c "/usr/bin/mysqldump -u $db_username -p$db_password $backup_db2 --routines > $($backup_location)$($backup_db2)_$($backup_date).sql"
docker exec -it $container_name bash -c "/usr/bin/mysqldump -u $db_username -p$db_password $backup_db3 --routines > $($backup_location)$($backup_db3)_$($backup_date).sql"

# Move MySQL backup to other location
Move-Item -Path $docker_volume_bk_folder $Backup_folder
