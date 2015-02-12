# tiddlywiki5-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['tiddlywiki5']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### tiddlywiki5::default

Include `tiddlywiki5` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[tiddlywiki5::default]"
  ]
}
```

## License and Authors

Author:: AzTek Native Ltd. (<peter.green@aztek-native.com>)
