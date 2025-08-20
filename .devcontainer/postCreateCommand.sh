#!/bin/bash
set -e

git config --global core.autocrlf false
git config --global core.filemode false

# NPM関連のエイリアス
echo 'alias npmfl="npm run format && npm run lint:fix"' >> ~/.bashrc

# CDK関連のエイリアス
echo 'alias cdksynth="npm run cdk synth"' >> ~/.bashrc

# Amazon Q CLIのエイリアス
echo 'alias qhelp="q --help"' >> ~/.bashrc
echo 'alias qv="q --version"' >> ~/.bashrc
echo 'alias ql="q login"' >> ~/.bashrc
echo 'alias qc="q chat"' >> ~/.bashrc
echo 'alias qd="q doctor"' >> ~/.bashrc

echo '
# プロファイル指定可能なAWS SSOログイン関数
awsloginp() {
  if [ -z "$1" ]; then
    echo "使用法: awsloginp <プロファイル名>"
    return 1
  fi
  aws sso login --profile "$1" && echo "現在の認証情報 ($1):" && aws sts get-caller-identity --profile "$1"
}

# プロファイル指定可能なAWS認証情報確認関数
awsidp() {
  if [ -z "$1" ]; then
    echo "使用法: awsidp <プロファイル名>"
    return 1
  fi
  aws sts get-caller-identity --profile "$1"
}

# プロファイル指定可能なAWS SSOログイン関数
awsloginp() {
  if [ -z "$1" ]; then
    echo "使用法: awsloginp <プロファイル名>"
    return 1
  fi
  aws sso login --profile "$1" && echo "現在の認証情報 ($1):" && aws sts get-caller-identity --profile "$1"
}

# プロファイル指定可能なAWS認証情報確認関数
awsidp() {
  if [ -z "$1" ]; then
    echo "使用法: awsidp <プロファイル名>"
    return 1
  fi
  aws sts get-caller-identity --profile "$1"
}' >> ~/.bashrc

# エイリアスのTipsを表示する関数
echo '
tips() {
  echo "-----------------------------------"
  echo "便利なコマンドTips"
  echo "-----------------------------------"
  echo "AWS関連："
  echo "  「awslogin」: AWS SSOログイン + 現在の認証情報確認（デフォルトプロファイル）"
  echo "  「awsid」: 認証情報確認のみ（デフォルトプロファイル）"
  echo "  「awsloginp <プロファイル名>」: 指定プロファイルでAWS SSOログイン + 認証情報確認"
  echo "  「awsidp <プロファイル名>」: 指定プロファイルで認証情報確認のみ"
  echo ""
  echo "NPM関連："
  echo "  「npmfl」: linter および formatter の実行（npm run format && npm run lint:fix）"
  echo "CDK関連："
  echo "  「cdksynth」: CloudFormation テンプレートの生成（npm run cdk synth）"
  echo ""
  echo "Amazon Q CLI関連："
  echo "  「qhelp」: Amazon Q CLIのヘルプを表示"
  echo "  「qv」: Amazon Q CLIのバージョンを表示"
  echo "  「ql」: Amazon Q CLIでログイン"
  echo "  「qc」: Amazon Q CLIでチャットを開始"
  echo "  「qd」: Amazon Q CLIでドクターを実行"
  echo ""
  echo "その他："
  echo "  「tips」: このヘルプメッセージを表示"
  echo "-----------------------------------"
  echo "例:"
  echo "  awslogin             ： デフォルトプロファイルでログイン"
  echo "  awsloginp dev-admin  ： devプロファイルでログイン"
  echo "  npmfl                ： linter および formatter の実行"
  echo "-----------------------------------"
}
' >> ~/.bashrc

source ~/.bashrc 2>/dev/null

echo "=== Post-create setup starting ==="

# Node.jsとNPMの設定確認
if command -v node &> /dev/null; then
    echo "✅ Node is available"
    echo "node version: $(node -v)"
else
    echo "❌ Node not found"
fi
if command -v npm &> /dev/null; then
    echo "✅ NPM is available"
    echo "npm version: $(npm -v)"
else
    echo "❌ NPM not found"
fi
# Amazon Q CLIの設定確認
if command -v q &> /dev/null; then
    echo "✅ Amazon Q CLI is available"
    echo "Amazon Q CLI version: $(q --version || echo "Version check failed but CLI is installed")"
else
    echo "❌ Amazon Q CLI not found"
fi
# AWS CLIの設定確認
if command -v aws &> /dev/null; then
    echo "✅ AWS CLI is available"
    echo "AWS CLI version: $(aws --version)"
else
    echo "❌ AWS CLI not found"
fi
# AWS CDKの設定確認
if command -v cdk &> /dev/null; then
    echo "✅ AWS CDK is available"
    echo "AWS CDK version: $(cdk --version)"
else
    echo "❌ AWS CDK not found"
fi
# Pythonの設定確認
if command -v python3 &> /dev/null; then
    echo "✅ Python3 is available"
    echo "Python version: $(python3 --version)"
else
    echo "❌ Python3 not found"
fi
# uvの設定確認
if command -v git &> /dev/null; then
    echo "✅ uv is available"
    echo "uv version: $(uv --version)"
else
    echo "❌ uv not found"
fi
# uvxの設定確認
if command -v git &> /dev/null; then
    echo "✅ uvx is available"
    echo "uvx version: $(uvx --version)"
else
    echo "❌ uvx not found"
fi
# Gitの設定確認
if command -v git &> /dev/null; then
    echo "✅ Git is available"
    echo "git version: $(git --version)"
else
    echo "❌ Git not found"
fi
# Graphvizの設定確認
if command -v dot &> /dev/null; then
    echo "✅ Graphviz is available"
    echo "Graphviz version: $(dot -V)"
else
    echo "❌ Graphviz not found"
fi

echo "=== Post-create setup completed ==="
echo "You can now use:"
echo "  - q --help          (Amazon Q CLI)"
echo "  - aws --help        (AWS CLI)"
echo "  - python3 --version (Python)"
