#!/usr/bin/env bash
# Scaffolding for a new, basic webdev project

if [ "$1" = "-h" ]; then
    funcUse="-----------------------------------------
    web_boiler.sh [projectName] [remoteGitRepository]  -- creates a blank project for web development, with the option to include a remote repository link
    web_boiler.sh [projectName]                        -- creates a blank project for web development
    web_boiler.sh -h                                   -- shows this help output
    
    where:
        -h                      shows this dialog message
        projectName             the name of the new project, no spaces
        remoteGitRepository     the link to the remote repository to connect to the local repository
    -----------------------------------------"
    echo "$funcUse"
    exit 0
fi

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
fi

# Make project structure
mkdir -p "$1"/src/css "$1"/src/js "$1"/src/images
touch "$1"/index.html "$1"/src/css/styles.css "$1"/src/css/modnorm.min.css "$1"/src/js/main.js
cd "$1"
touch .gitignore

# Add boilerplate code to test HTML, CSS, and JS
echo "progress,sub,sup{vertical-align:baseline}*,::after,::before{box-sizing:border-box}html{line-height:1.15;-webkit-text-size-adjust:100%;-moz-tab-size:4;tab-size:4}body{margin:0;font-family:system-ui,-apple-system,'Segoe UI',Roboto,Helvetica,Arial,sans-serif,'Apple Color Emoji','Segoe UI Emoji'}hr{height:0;color:inherit}abbr[title]{text-decoration:underline dotted}b,strong{font-weight:bolder}code,kbd,pre,samp{font-family:ui-monospace,SFMono-Regular,Consolas,'Liberation Mono',Menlo,monospace;font-size:1em}small{font-size:80%}sub,sup{font-size:75%;line-height:0;position:relative}sub{bottom:-.25em}sup{top:-.5em}table{text-indent:0;border-color:inherit}button,input,optgroup,select,textarea{font-family:inherit;font-size:100%;line-height:1.15;margin:0}button,select{text-transform:none}[type=button],[type=reset],[type=submit],button{-webkit-appearance:button;appearance:button;}::-moz-focus-inner{border-style:none;padding:0}:-moz-focusring{outline:ButtonText dotted 1px}:-moz-ui-invalid{box-shadow:none}legend{padding:0}::-webkit-inner-spin-button,::-webkit-outer-spin-button{height:auto}[type=search]{-webkit-appearance:textfield;appearance:textfield;outline-offset:-2px}::-webkit-search-decoration{-webkit-appearance:none;appearance:none;}::-webkit-file-upload-button{-webkit-appearance:button;appearance:button;font:inherit}summary{display:list-item}html{font-size:62.5%;}body{font-size:1.6rem;}img{width:100%;height:auto;user-select:none;}button{color:inherit;}a,button{touch-action: manipulation;}svg{height:100%;width:100%;fill:currentColor;pointer-events:none;}iframe,video{display:inline-block;height:auto;width:100%}" >> src/css/modnorm.min.css
{
    echo '<!DOCTYPE html>'
    echo "<html lang=\"en\">"
    echo "<head>"
    echo "    <meta charset=\"UTF-8\">"
    echo "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">"
    echo "    <meta name=\"author\" content=\"YOUR NAME HERE\">"
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
    echo "    paragraphElement.textContent = String('If this element is present, Hello World from JavaScript!');"
    echo "    paragraphElement.style.color = 'blue';"
    echo ""
    echo "    const jsSection = document.getElementById('jsContentTest');"
    echo "    jsSection.appendChild(paragraphElement);"
    echo "}"
} >> src/js/main.js

{
echo "*.ignore"
echo "*.eslintrc"
echo ""
echo "*.zip"
echo "*.7z"
echo "*.rar"
echo "*.tar.gz"
echo ""
echo ".config"
echo ".DS_Store"
echo ".cache"
echo ""
echo "logs"
echo "*.log"
echo "pm-debug.log* "
echo "yarn-debug.log* "
echo "yarn-error.log* "
echo "lerna-debug.log* "

} >> .gitignore

# Attempt to make repo, if fail, delete project
if [ "$VAR_GIT" = true ]; then
    git init
    git add .
    git commit -m "Initial Commit - Added Boilerplate Code from Shell Script"
    git branch -M main
    git remote add origin "$2"
fi

echo "Successfully created project. Attempting to open VSCode."

if [ "$VAR_GIT" = true ]; then
    echo "To push repository: git push -u origin main"
fi

# Open VSCode and index.html, attempt to open on various version (Linux, MACOS/Unix, Windows)
code .
xdg-open index.html || open index.html || explorer.exe index.html

exit 0
