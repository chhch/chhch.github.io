---
title: Neos Installation
tags: [neos, php]
---

Benötigte Anwendungen:

```shell
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install php7.2
sudo apt-get install php7.2-mysql
sudo apt-get install php7.2-mbstring
sudo apt-get install php7.2-cli
sudo apt-get install php7.2-xdebug
sudo apt-get install php7.2-xml
sudo apt install php-imagick
php -m
curl -s https://getcomposer.org/installer | php
chmod +x composer.phar
php composer.phar create-project --no-dev neos/neos-base-distribution myneos/
```

php7.2-mbstring php7.2-cli php7.2-xdebug php7.2-xml php-imagick

Intellij: Install Neos Plugin by Christian and Fluid Plugin by Stefan

Run `./flow server:run`

Start MariaDB with Docker `docker run --name mariadb -e MYSQL_ROOT_PASSWORD=password -d --publish 3306:3306 mariadb`

---

https://www.getcomposercat.com/


## Neos

Replace scale-down with scale-none because scale-down renders either like scale-none or scale-container, and scale-container is already an option to select.

```ini
[XDebug]
xdebug.remote_enable = 1
xdebug.remote_autostart = 1
```

- in vscode launch json erstellen, Ausschnitt:

```json
"configurations": [
{
    "name": "Listen for XDebug",
    "type": "php",
    "request": "launch",
    "port": 9001
},
```

- port auf 9001 setzten
- breakpoint testen:
  - projekt Web/index.php (docker-composte volumes anpassen!)
  - neuos test Packages/Framework/Neos.Flow/Scripts/PhpDevelopmentServerRouter.php

ggf. weitere Einstellungen remote Debugging nötig

---

apt install php-xdebug

**Verzeichnisstruktur**

- `Packages/Sites/Projekt/Configuration`: Enthält die Deklarationen verschiedener NodeTypes als `.yaml`
- `Packages/Sites/Projekt/Resources/Private/Templates`: Templates mit _Fluid_

**Fluid** = HTML + Fluid-Tags: `<div><f:format.raw>{text}</f:format.raw></div>` oder inline `<div>{text -> f:format.raw()}<div>`
**TypoScript** `seite = Page { templatePath = Standard.html, text = <b>Hallo Welt!</b>`

**EEL** erweitert TypoScript um Ausdrücke. `text=${node.property}`
**FlowQuery** verarbeitet kontextsensitive EEL-Inhalte. `text=${q(node).children().first().property('title')}`
**Fizzle** ermöglicht Filter-Opertatoren und ist inspiriert durch Selektoren-Syntax in CSS. `text=${q(node).children("[hidden != true"]).count()}`

**Page-Objekt** verantwortlich für die Front-End Ausgabe.

**Konventionen**

- Objektnamen in TypoScript/Fusion beginnen mit einem Kleinbuchstaben
- Dateinamen beginnen mit einem Großbuchstaben

**Kontext**

- Application Context: Configure Neos to behave in a specific way; set ist by environment variable FLOW_CONTEXT, default developer context
- Security Context: Information Roles, Authentication Accounts, may avoid it and use policies
- (specific) Node Context: visibility, workspace, dimensions (backend: user workspace, frontend: live workspace)
- Context in Fusion: Current variables in rendering stack (you never access the fusion context, it is in background)
- EEL-Context: Variables available in EEL Expression context contains more variables than the fusion context. Whenever you pass a expression, fusion will pass the variables to EEL

**Caches**

- Redis
- everything is cached to filesystem -» dont scale well, may use cache configuration

**FusionArray**

- not an Array, sondern String
- NeosFusionArray gives an Array (use this)
- Content Cache: 3 modes: cached, uncached, dynamic cahded

**NodeType** configuration ?over reposity?
**Prototype** just rendering

bind nodeType.name only connection NodeType and Prototype you can leave this out
Prototypes generator -» not needed Fusion code automatically 

- Routing very difficult (keep in mind sub request exists main request)
- policies pretty hard
- Version really important keep updated (migration tool)
- node:repair can break more, use node:repair dry run, it can get worst

---

backend shows two trees. one contains sites, the other contains content. In reality, it is only one tree.

**NodeTypes** 3 Parts

- YAML Definition (Was ist es?)
- TypoScript Control (Wie funktioniert es?) (TypoScript/Fusion autowired, so not needed. Only for complex stuff)
- Fluid Rendering (Was tut es?) (Fluid Template)

You'll need this often: `./flow flow:cache:flush`

--- 

Neos baut auf Flow auf

SSO auf Flow-Ebene

Backup nicht mit Neos Funktionen, sondern mit Ordnern/Daten
`composer --dry-run update`
`composer self-update`
`flow doctrine migrate` schema abgleichen

Data/Temporary kann gelöscht werden, wird von Neo neu erstellt
Backup: Data/Persistence/Resources und DB
FLOW_CONTEXT = development
Globale Konfig überschreibt lokale konfig
`flow configuration show --path`

NodeTypes: Struktur
Template: Aussehen
Fusion: Verhalten

- `Configuration/` Application specific configuration
- `Data/` Persistent and temporary Data
- `Packages/Framework` Packages which are part of the offical Flow distribution
- `Packages/Application` Application specific packages
- `Packages/Libraries` 3rd party Libraries
- `Web/` Public web root
- `Packages/Sites`

## Debugging

Debug Neos with `<f:debug>{whatImLookingFor}</f:debug>` in Fluid template.

`{node -> f:debug()}`

## NodeTypes

**Template**

```html
{namespace neos=Neos\Neos\ViewHelpers}
<div>
    <button  style="color: {buttonColor}">
        {neos:contentElement.editable(property: 'buttonText')}
    </button>
</div>
```

**NodeType**

```yaml
'Projekt:TestButton':
  superTypes:
    'Neos.Neos:Content': true
  label: ${'My Button (' + q(node).property('buttonColor') + ')'}
  constraints: 
    nodeTypes: 
      'Neos.NodeTypes:Headline': true
      '*': false
  ui:
    label: 'My Button'
    icon: 'play'
    help: 
      message: 'This button is only created for testing purposes.'
    inspector:
      tabs:
        'myTab':
          label: 'Test Tab'
          icon: 'far fa-lightbulb' # https://fontawesome.com/icons?d=gallery&m=free
      groups:
        'myGroup':
          label: 'My Group'
          icon: 'palette'
          tab: 'myTab'
          collapsed: true
  properties:
    'buttonText':
      type: string
      defaultValue: 'Default Button Text'
      ui:
        inlineEditable: true
        inline:
          editorOptions:
            formatting:
              strong: true
              em: true
              removeFormat: true
    'buttonColor':
      type: string
      defaultValue: 'red'
      ui:
        label: 'Color'
        reloadIfChanged: true
        help: 
          message: 'Color of the button text'
        inspector:
          group: 'myGroup'
          editor: 'Neos.Neos/Inspector/Editors/SelectBoxEditor'
          editorOptions:
            values:
              'red':
                label: 'Rot'
                icon: 'icon-legal'
              'blue':
                label: 'Blau'
                icon: 'icon-fire'
              'orange':
                label: 'Orange'
```

## Node Types

`Packages/Application/Neos.NodeTypes/Configuration/NodeTypes.Content.Image.yaml`

```yaml
'Neos.NodeTypes:Image':
  superTypes:
    'Neos.Neos:Content': true
    'Neos.NodeTypes:ContentImageMixin': true
  ui:
    label: i18n
    icon: 'icon-picture'
    position: 300
```

`Packages/Application/Neos.NodeTypes/Configuration/NodeTypes.Mixins.yaml`

```yaml
# ...
'Neos.NodeTypes:ContentImageMixin':
  abstract: true
  superTypes:
    'Neos.NodeTypes.BaseMixins:ContentImageMixin': true

'Neos.NodeTypes:ImageMixin':
  abstract: true
  superTypes:
    'Neos.NodeTypes.BaseMixins:ImageMixin': true

'Neos.NodeTypes:ImageAlignmentMixin':
  abstract: true
  superTypes:
    'Neos.NodeTypes.BaseMixins:ImageAlignmentMixin': true

'Neos.NodeTypes:ImageCaptiovnMixin':
  abstract: true
  superTypes:
    'Neos.NodeTypes.BaseMixins:ImageCaptionMixin': true
# ...
```

`Packages/Application/Neos.NodeTypes.BaseMixins/Configuration/NodeTypes.Mixin.ContentImage.yaml`

```yaml

'Neos.NodeTypes.BaseMixins:ContentImageMixin':
  abstract: true
  superTypes:
    'Neos.NodeTypes.BaseMixins:ImageMixin': true
    'Neos.NodeTypes.BaseMixins:LinkMixin': true
    'Neos.NodeTypes.BaseMixins:ImageCaptionMixin': true
    'Neos.NodeTypes.BaseMixins:ImageAlignmentMixin': true
  properties:
    link:
      ui:
        inspector:
          group: 'image'
```

`Packages/Application/Neos.NodeTypes.BaseMixins/Configuration/NodeTypes.Mixin.Image.yaml`

```yaml
'Neos.NodeTypes.BaseMixins:ImageMixin':
  abstract: true
  ui:
    inspector:
      groups:
        image:
          label: i18n
          position: 5
          icon: 'icon-image'
  properties:
    image:
      type: Neos\Media\Domain\Model\ImageInterface
      ui:
        label: i18n
        reloadIfChanged: true
        inspector:
          group: 'image'
          position: 50
    alternativeText:
      type: string
      ui:
        label: i18n
        reloadIfChanged: true
        inspector:
          group: 'image'
          position: 100
    title:
      type: string
      ui:
        label: i18n
        reloadIfChanged: true
        inspector:
          group: 'image'
          position: 150
```

## Frontend, Backend und LOM Styles

In `Packages/Sites/Projekt/Resources/Private/Templates/Page/MetaScriptsAndStyles.html`

- Frontend: `frontend/Styles/Host.css`
- Backend: `css/index.css`
- scormframeStylesheets/SCORM-Player Frame: `css/index.css`

## Package installieren

1. `composer.json`
2. `Packages/Sites/Projekt/composer.json` abhaengikeiten anpassen
3. ggf. Dateien kopieren, falls nicht im Containe vorhanden
4. `./flow neos.flow:package:rescan`
5. `docker-compose down` dann `docker-compose up --build`

## Migration

Add `.yaml` to `Packages/Sites/Projekt/Migrations/ContentRepository`.

Check with `./flow node:migrationstatus`, if it was added

Add two things to the `yaml`:

- Which nodes to select to apply the migration - this is called a **filter**.
- What to do with the selected nodes. This is called a **transformation**.

**Filters**:

- `DimensionValues`
- `IsRemoved`
- `NodeName`
- `NodeType`
- `PropertyNotEmpty`
- `Workspace`

**Transformations**:

- `AddDimensions`
- `AddNewProperty`
- `ChangeNodeType`
- `ChangePropertyValue`
- `RemoveNode`
- `RemoveProperty`
- `RenameDimension`
- `RenameNode`
- `RenameProperty`
- `SetDimensions`
- `StripTagsOnProperty`

**Links**:

- [https://docs.neos.io/cms/manual/content-repository/node-migrations](https://docs.neos.io/cms/manual/content-repository/node-migrations)

- [https://sandstorm.de/de/blog/post/how-to-migrate-nodes-in-neos.html](https://sandstorm.de/de/blog/post/how-to-migrate-nodes-in-neos.html)
