# github-contributors

`Github Contributors` aims to provide an easy way to collect all contributors of a given project at Github.
Since Github only lists the top 100 contributors, this project has the goal to show you all people helping your project.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  github-contributors:
    github: mauricioabreu/github-contributors
```


## Usage

Before running the command-line tool, add a `GITHUB_SECRET` to your environment variables.


```shell
$ contributors django/django

```

## Contributing

1. Fork it ( https://github.com/mauricioabreu/github-contributors/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
