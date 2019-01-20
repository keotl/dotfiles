list extensions 

```
vscode --list-extensions > extensions.txt
```

install extensions
```
while read e; do
  vscode --install-extension "$e"
done <extensions.txt

code 
```
