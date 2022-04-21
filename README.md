# publish-gem-to-github

Release your Ruby Gem to GitHub Packages

This Action has been heavily influenced by [Jstastny's Publish-Gem-to-Github Action](https://github.com/jstastny/publish-gem-to-github)

## Usage

```yaml
jobs:
  release:
    runs-on: ubuntu-latest
      - name: Checkout
        uses: actions/checkout@v2

      - name: Build and publish to GitHub Package
        uses: actionshub/publish-gem-to-github@master
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          owner: ${{ secrets.OWNER }}
```
