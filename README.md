# Wiki Action

A [GitHub Action](https://help.github.com/en/actions) that updates your project's [wiki](https://help.github.com/en/github/building-a-strong-community/about-wikis) **(with a custom sidebar)** from a workflow. **This project is in BETA. Please report bugs if encountered.**

## Usage

```yml
name: Update Wiki

# on: [push]

# recommended
on:
  push:
    paths:
      - 'wiki/**'
    branches:
      - master

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1

      - uses: ineshbose/wiki-action@v1
        with:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          WIKI_DIR: 'wiki'
          AUTO_SIDEBAR: true
```

<table>
<thead>
  <tr>
    <th>Argument</th>
    <th>Required</th>
    <th>Default</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>GH_TOKEN</td>
    <td>Yes</td>
    <td></td>
    <td>GitHub Token required to make changes. You can use ${{ secrets.GITHUB_TOKEN }}.</td>
  </tr>
  <tr>
    <td>WIKI_DIR</td>
    <td>No</td>
    <td>wiki</td>
    <td>The directory relative to the repository root where the wiki files are.</td>
  </tr>
  <tr>
    <td>WIKI_IGNORE</td>
    <td>No</td>
    <td></td>
    <td>Files and directories (separated with a space) that are not supposed to be on the wiki (and sidebar).</td>
  </tr>
  <tr>
    <td>AUTO_SIDEBAR</td>
    <td>No</td>
    <td>False</td>
    <td>Add files onto _Sidebar.md for the Wiki according to the directory structure.</td>
  </tr>
  <tr>
    <td>SIDEBAR_IGNORE</td>
    <td>No</td>
    <td></td>
    <td>Files and directories (separated with a space) that are not supposed to be listed on the sidebar.</td>
  </tr>
</tbody>
</table>

### Sidebar Customisation

You can still create a `_Sidebar.md` with your project logo and more listings on it, and the rest of the items will be added towards the end. **Make sure that the file ends with an empty line.**