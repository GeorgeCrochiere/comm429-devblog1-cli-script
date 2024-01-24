#!/usr/bin/env bash
# Scaffolding for a new, basic webdev project

VAR_GIT=false
if [ -z "$1" ]; then
    echo "Error: No arguments provided. Requires a project name."
    exit 1
elif [ -n "$2" ]; then
    VAR_GIT=true

    # If git is true, check for git installation and conditions
    if ! [ -x "$(command -v git)" ]; then
        echo 'Error: git is not installed. Cannot use to create a git repository. Exiting...'
        exit 2
    elif [ -z "$(git config --get user.name)" ] || [ -z "$(git config --get user.email)" ]; then
        echo 'Error: git is not configured (username, email). Cannot create repository.'
        echo 'Use: git config --global user.name "NAME"'
        echo 'Use: git config --global user.email "VALID EMAIL"'
        echo 'Exiting...'
        exit 3
    fi
    echo "Git is properly installed. Continuing..."

    # Test validity of remote repository
    git init
    git remote add origin "$2"
    if ! git push -u origin main; then
        echo "Error: Second argument error. The second argument regarding the creation of a git repository. Value passed must be a valid remote repository. Exiting..."
        rmdir -r -force /.git
        exit 4
    fi
fi

mkdir "$1"
touch "$1"/index.html "$1"/src/css/styles.css "$1"/src/css/modnorm.min.css "$1"/src/js/main.js
cd "$1"/src
mkdir images
cd ..

echo "progress,sub,sup{vertical-align:baseline}*,::after,::before{box-sizing:border-box}html{line-height:1.15;-webkit-text-size-adjust:100%;-moz-tab-size:4;tab-size:4}body{margin:0;font-family:system-ui,-apple-system,'Segoe UI',Roboto,Helvetica,Arial,sans-serif,'Apple Color Emoji','Segoe UI Emoji'}hr{height:0;color:inherit}abbr[title]{text-decoration:underline dotted}b,strong{font-weight:bolder}code,kbd,pre,samp{font-family:ui-monospace,SFMono-Regular,Consolas,'Liberation Mono',Menlo,monospace;font-size:1em}small{font-size:80%}sub,sup{font-size:75%;line-height:0;position:relative}sub{bottom:-.25em}sup{top:-.5em}table{text-indent:0;border-color:inherit}button,input,optgroup,select,textarea{font-family:inherit;font-size:100%;line-height:1.15;margin:0}button,select{text-transform:none}[type=button],[type=reset],[type=submit],button{-webkit-appearance:button;appearance:button;}::-moz-focus-inner{border-style:none;padding:0}:-moz-focusring{outline:ButtonText dotted 1px}:-moz-ui-invalid{box-shadow:none}legend{padding:0}::-webkit-inner-spin-button,::-webkit-outer-spin-button{height:auto}[type=search]{-webkit-appearance:textfield;appearance:textfield;outline-offset:-2px}::-webkit-search-decoration{-webkit-appearance:none;appearance:none;}::-webkit-file-upload-button{-webkit-appearance:button;appearance:button;font:inherit}summary{display:list-item}html{font-size:62.5%;}body{font-size:1.6rem;}img{width:100%;height:auto;user-select:none;}button{color:inherit;}a,button{touch-action: manipulation;}svg{height:100%;width:100%;fill:currentColor;pointer-events:none;}iframe,video{display:inline-block;height:auto;width:100%}" >> src/css/modnorm.min.css
{
    echo '<!DOCTYPE html>'
    echo "<html lang=\"en\">"
    echo "<head>"
    echo "    <meta charset=\"UTF-8\">"
    echo "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
    echo "    <meta name=\"author\" content=\"George D. Crochiere\">"
    echo "    <title>$1</title>"
    echo "    <link rel=\"stylesheet\" href=\"./src/css/modnorm.min.css\" />"
    echo "    <link rel=\"stylesheet\" href=\"./src/css/styles.css\" />"
    echo "</head>"
    echo "<body>"
    echo "    <script src=\"./src/js/main.js\" defer></script>"
    echo "    <h1>Hello World from HTML!</h1>"
    echo "    <h2>If red, Hello world from CSS!</h2>"
    echo "    <div id=\"jsContentTest\"></div>"
    echo "</body>"
    echo "</html>"
} >> index.html

{
    echo "h2 {"
    echo "    color: red;"
    echo "}"
} >> src/css/styles.css

{
    echo "testJS();"
    echo ""
    echo "function testJS() {"
    echo "    const paragraphElement = document.createElement('p');"
    echo "    correctGuess.textContent = String('If this element is present, Hello World to JavaScript!');"
    echo "    correctGuess.style.color = 'blue';"
    echo ""
    echo "    const jsSection = document.getElementById('jsContentTest');"
    echo "    jsSection.appendChild(paragraphElement);"
    echo "}"
} >> src/js/main.js

code .

if [ "$VAR_GIT" = true ]; then
    git add .
    git commit -m "Initial Commit - Added Boilerplate Code from Shell Script"
    git branch -M main
    git push -u origin main
fi
