#!/bin/bash

HEYWEEK_PATH=""
initArch() {
  ARCH=$(uname -m)
    case $ARCH in
    aarch64) ARCH="arm64" ;;
    arm64) ARCH="arm64" ;;
    x86) ARCH="i386" ;;
    x86_64) ARCH="x86_64" ;;
    i686) ARCH="i386" ;;
    i386) ARCH="i386" ;;
    esac
    echo "ARCH=$ARCH"
}

initDestination() {
    if [ -n "$BINDIR" ]; then
      if [ ! -d "$BINDIR" ]; then
        # The second instance of $BINDIR is intentionally a literal in this message.
        # shellcheck disable=SC2016
        fail "$BINDIR "'($BINDIR)'" folder not found. Please create it before continuing."
      fi
      HEYWEEK_PATH="$BINDIR"
    else
      HEYWEEK_PATH="/usr/local/bin"
    fi
    echo "Installing Heyweek CLI in $HEYWEEK_PATH"
}

initOs() {
  OS=$(uname -s)
  case "$OS" in
  Linux*) OS='Linux' ;;
  Darwin*) OS='macOS' ;;
  MINGW*) OS='Windows' ;;
  MSYS*) OS='Windows' ;;
  esac
  echo "OS=$OS"
}

fail() {
  echo "$1"
  exit 1
}

initDownloadTool() {
  if command -v "curl" >/dev/null 2>&1; then
      DOWNLOAD_TOOL="curl"
    elif command -v "wget" >/dev/null 2>&1; then
      DOWNLOAD_TOOL="wget"
    else
      fail "You need curl or wget as download tool. Please install it first before continuing"
    fi
    echo "Using $DOWNLOAD_TOOL as download tool"
}

getFile() {
  GETFILE_URL="$1"
  GETFILE_FILE_PATH="$2"
  if [ "$DOWNLOAD_TOOL" = "curl" ]; then
    GETFILE_HTTP_STATUS_CODE=$(curl -s -w '%{http_code}' -L "$GETFILE_URL" -o "$GETFILE_FILE_PATH")
  elif [ "$DOWNLOAD_TOOL" = "wget" ]; then
    wget --server-response --content-on-error -q -O "$GETFILE_FILE_PATH" "$GETFILE_URL"
    GETFILE_HTTP_STATUS_CODE=$(awk '/^  HTTP/{print $2}' "$TMP_FILE")
  fi
  echo "$GETFILE_HTTP_STATUS_CODE"
}

checkVersion() {
   if [ "$DOWNLOAD_TOOL" = "curl" ]; then
      VERSION=$(curl --silent "https://api.github.com/repos/heyweek/homebrew-heyweek-cli/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    elif [ "$DOWNLOAD_TOOL" = "wget" ]; then
      VERSION=$(wget -q -O - "https://api.github.com/repos/heyweek/homebrew-heyweek-cli/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    fi

    if [ "$VERSION" = "" ]; then
        echo "Cannot determine latest tag."
        exit 1
      fi
}

bye() {
  BYE_RESULT=$?
  if [ "$BYE_RESULT" != "0" ]; then
    echo "Failed to install $PROJECT_NAME"
  fi
  exit $BYE_RESULT
}

installationProcess() {
  if [ -z "$1" ]; then
    checkVersion
    else
      VERSION=$1
    fi

  RELEASE_API_URL=https://github.com/heyweek/homebrew-heyweek-cli/releases/download

  echo "Version ${VERSION}"
  if [ "$OS" = "Linux" ]; then
    APPLICATION_EXT="_${OS}_${ARCH}.tar.gz"
  else
    APPLICATION_EXT="_${OS}_${ARCH}.zip"
  fi
  
  if [ "$OS" = "Windows" ]; then
      HEYWEEK_PATH="$PWD/bin"
  fi

  DOWNLOAD_URL="${RELEASE_API_URL}/${VERSION}/Heyweek_${VERSION}${APPLICATION_EXT}"
  echo "Download url $DOWNLOAD_URL"

  INSTALLATION_TMP_FILE="/tmp/Heyweek_${VERSION}${APPLICATION_EXT}"
  httpStatusCode=$(getFile "$DOWNLOAD_URL" "$INSTALLATION_TMP_FILE")

  if [ "$httpStatusCode" -ne 200 ]; then
     fail "Failed to download load Heyweek CLI for installation, if this persist report the issue"
  fi


  INSTALLATION_TMP_DIR="/tmp/heyweek"
  mkdir -p "$INSTALLATION_TMP_DIR"

  if [ "$OS" = "Linux" ]; then
    tar xf "$INSTALLATION_TMP_FILE" -C "$INSTALLATION_TMP_DIR"
  else
    unzip -d "$INSTALLATION_TMP_DIR" "$INSTALLATION_TMP_FILE"
  fi

  INSTALLATION_TMP_BIN="$INSTALLATION_TMP_DIR/Heyweek_${VERSION}_${OS}_${ARCH}/hw"
  sudo cp "$INSTALLATION_TMP_BIN" "$HEYWEEK_PATH"

  rm -rf "$INSTALLATION_TMP_DIR"
  rm -f "$INSTALLATION_TMP_FILE"

  if [ -x "$(command -v hw)" ]; then
      echo "Heyweek CLI ${VERSION} installed successfully in ${HEYWEEK_PATH}"
  else
    fail "Heyweek CLI failed to install. Try again or report an issue"
  fi
}

trap "bye" EXIT
initDestination
set -e
initOs
initArch
initDownloadTool
installationProcess "$1"