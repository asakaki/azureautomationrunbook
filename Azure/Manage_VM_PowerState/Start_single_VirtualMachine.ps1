# 実行用パラメーター
param (
    [parameter(mandatory)][String]$VmName,
    [parameter(mandatory)][String]$ResourceGroupName
)

# 事前準備
$ErrorActionPreference = "Continue"

# Azureにログイン
$login = Connect-AzAccount -Identity
if (!($login)) {
    Write-Output "Azureへのログインに失敗しました。"
    Write-Error -Message $Error[0] -ErrorAction "Stop"
}

# 仮想マシンが存在することを確認
if (!(Get-AzVm -Name $VmName -ResourceGroupName $ResourceGroupName)) {
    Write-Output "仮想マシン: ${VmName}が見つかりません。"
    Write-Error -Message $Error[0] -ErrorAction "Stop"
}

# 仮想マシンを起動
$result = Start-AzVm -Name $VmName -ResourceGroupName $ResourceGroupName
if (!($result)) {
    Write-Output "仮想マシン: ${VmName}の起動に失敗しました。"
    Write-Error -Message $Error[0] -ErrorAction "Stop"
}

# Azureからログアウト
Disconnect-AzAccount
