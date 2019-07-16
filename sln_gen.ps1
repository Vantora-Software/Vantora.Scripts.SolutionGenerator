param([string]$sln)

if ($sln.Length -gt 0) {
    dotnet new sln -n $($sln)
    dotnet new classlib -n $($sln) -o src\library
    del .\src\library\Class1.cs

    md .\src\WindowsService

    dotnet new xunit -o tests\integration
    dotnet add tests\integration\integration.csproj reference src\library\$($sln).csproj
    del .\tests\integration\UnitTest1.cs

    dotnet new xunit -o tests\unit
    dotnet add tests\unit\unit.csproj reference src\library\$($sln).csproj
    del .\tests\unit\UnitTest1.cs
} else {
    Write-Host "No argument was supplied for the solution name"
}