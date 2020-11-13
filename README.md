# vim 配置说明

添加一些 vim配置 的配置说明
当前配置基于 nvim 进行配置，添加了常用的插件，并支持java。

## 环境准备
```shell script
npm install -g neovim
pip3 install pylint
npm install -g typescript
pip3 install jedi
```


## Plug 插件
```shell script
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```


## coc-settings.json
特别说明，要使有 coc 的java语法提示，必须指定jdk为 JDK11，否则报错
```json
{
    "suggest.noselect": true,
    "suggest.enablePreselect": false,
    "codeLens.enable": true,
    "java.home": "/Library/Java/JavaVirtualMachines/jdk-11.0.9.jdk/Contents/Home",
    "suggest.completionItemKindLabels": {
        "class": "\uf0e8",
        "color": "\ue22b",
        "constant": "\uf8fe",
        "default": "\uf29c",
        "enum": "\uf435",
        "enumMember": "\uf02b",
        "event": "\ufacd",
        "field": "\uf93d",
        "file": "\uf723",
        "folder": "\uf115",
        "function": "\u0192",
        "interface": "\uf417",
        "keyword": "\uf1de",
        "method": "\uf6a6",
        "module": "\uf40d",
        "operator": "\uf915",
        "property": "\ue624",
        "reference": "\ufa46",
        "snippet": "\ue60b",
        "struct": "\ufb44",
        "text": "\ue612",
        "typeParameter": "\uf728",
        "unit": "\uf475",
        "value": "\uf89f",
        "variable": "\ue71b"
    },
    "coc.preferences.formatOnSaveFiletypes": [
        "json",
        "java",
        "python",
        "css",
        "dart",
        "html",
        "javascript"
    ]
}
```