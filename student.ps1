Do {

$SqlServer = 'DESKTOP-7080JKI'
$SqlDatabase = 'student'
$userName = 'siddu'
$password = 'Siddarth@36'




$ConnectionString = "Server=$SqlServer;Database=$SqlDatabase;User ID=$userName;Password=$password;"
$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString=$ConnectionString
$conn.Open()

$Sql = "SELECT [id],[name],[class],[marks] FROM [student].[dbo].[stu_tab_1]"
$command = $conn.CreateCommand()
$command.CommandText=$Sql
$rdr = $command.ExecuteReader()

$endpoint = "https://api.powerbi.com/beta/019eccb4-5ec4-4590-9934-7f4a26e84c1f/datasets/a157fc8d-0765-4532-a2ac-007885d717ea/rows?key=suF7lrGrAhep9K7ux9eh%2BvPf%2BXKrycld%2F%2BodqkTBPoAyZFams%2BJNiGFj9oyUVXThkGCmxmZLzDgp44E1Ng6BZg%3D%3D"

while($rdr.Read()){
$payload = @{
"id" =$rdr['id']
"name" = $rdr['name']
"class" = $rdr['class']
"marks" = $rdr['marks']

}
Invoke-RestMethod -Method Post -Uri "$endpoint" -Body (ConvertTo-Json @($payload))
}


$conn.Close();
$conn.Dispose();



sleep 1
}




while ($true)
