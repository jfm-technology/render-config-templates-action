# Render Config Templates Action

This action processes files with a specified file extension as Jinja2 templates.

Variables used come from the (JSON encoded) `vars` argument (see below for
example usages).

## Inputs

### `relative-working-directory`

Directory to search for template files (relative to workspace dir). Defaults to "."

### `template-extension`

File extension to use as templates. Files will be processed as templates and the
result is stored as the template filename minus the extension. Defaults to
"production"

### `remove-templates`

Remove template files as soon as they habe been processed? Default is false.

### `vars`

**Required** JSON encoded map of variables for the Jinja2 engine.

## Outputs

None

## Example usage

```yaml
uses: jfm-technology/render-config-templates-action@master
with:
  template-extension: production
  remove-templates: true
  vars: '{"github":${{ toJson(github) }},"vars":${{ toJson(vars) }}}'
```
