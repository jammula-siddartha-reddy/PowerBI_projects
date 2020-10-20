Do
{
$SqlServer = 'DESKTOP-7080JKI'
$SqlDatabase = 'Axis'
$userName = 'siddu'
$password = 'Siddarth@36'


$ConnectionString = "Server=$SqlServer;Database=$SqlDatabase;User ID=$userName;Password=$password;"
$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString=$ConnectionString
$conn.Open()

$Sql = "SELECT  [x],[y] FROM [Axis].[dbo].[x_y]"
$command = $conn.CreateCommand()
$command.CommandText=$Sql
$rdr = $command.ExecuteReader()


$endpoint = "https://api.powerbi.com/beta/019eccb4-5ec4-4590-9934-7f4a26e84c1f/datasets/59f98777-3954-4f1e-8d5f-31bfa45691ee/rows?key=A6pU5UEkkRqti3tar5qc%2FLmGRBs3AD53JOvPXNeAMxHAyLF7loCfo3k4ue7Mb6yTbB8iArgz4iLm7%2F3arlhUvg%3D%3D"
while($rdr.Read())
{
$payload = @{
"x" = $rdr['x']
"y" = $rdr['y']
}
}
Invoke-RestMethod -Method Post -Uri "$endpoint" -Body (ConvertTo-Json @($payload))
$conn.Close();
$conn.Dispose();

sleep(1)
}
while($true)