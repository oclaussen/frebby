# frebby

## What is this?

frebby is a very, very simple Ruby script that generates JSON out of a Ruby
based configuration language. It is intended as an alternative to the numerous
attempts to write a more human-readable language for tool configuration (YAML,
TOML, HCL, ...).

In contrast to these other languages, frebby is not a full blown parser. Instead
it takes a bunch of Ruby code, `eval`s and turns it into JSON. The result can
then be fed to basically anything that can read JSON.

## Why should I use this?

Everyone has a different opinion on how powerful a configuration language should
be. Some people prefer a very strict and foolproof language while others prefer
full blown programming languages. For most, the answer is somewhere in the
middle. This tool is aimed at those who sit quite far in the programming
language camp and who feel YAML and HCL are lacking in possibilities.

### The Good

* Use all the power of a full programming language for tools that usually
  wouldn't support this (Ansible, Terraform, Packer, ...)

* Keep all your infrastructure defined in one consistent language

* Works with anything that expects configuration files in JSON format
  (or YAML, or HCL, since these are just supersets of JSON)

* No dependencies (except Ruby, of course)

### The Bad

* You need Ruby installed, and some level of Ruby knowledge will help also

* It is another tool in you build chain and adds some level of complexity

* There are some very good arguments for keeping the configuration for your
  infrastructure as simple and obvious as possible. Using a turing complete
  configuration language to set up the most critical parts of your
  infrastructure just asks for trouble. With great power and so on.

### The Ugly

* Due to the way frebby uses (abuses?) the Ruby programming language, there
  are some quirks where it will not immediately work the way you would expect.
  See the [quirks chapter](README.md#quirks) or the
  [examples](examples/04_quirks) details.

## How do I use this?

### Installation & Usage

At its core, frebby is just a very simple ruby script without dependencies. In
theory, it is enough to just download the [main file](bin/frebby) and put it
anywhere in your `$PATH`. However, there are more convenient options
available:

Usually, you will want to install frebby directly from rubygems:

```bash
gem install frebby
```

Once installed, usage is pretty simple: The `frebby` command simply takes any
number of configuration files as input, either as arguments or from stdin,
and output JSON on stdout. There are no other arguments or configurations
to worry about.

```bash
frebby /path/to/config/file.rb /path/to/other/config.rb > /new/json/config.json

# alternatively:
cat /path/to/config/file.rb | frebby > /new/json/config.json
```

Aternatively, if you don't want to install Ruby locally, you can use frebby
out of Docker:

```bash
docker pull oclaussen/frebby

# example usage:
docker run --rm oclaussen/frebby /path/to/config/file.rb
```

### Configuration syntax

Configuration for frebby is written in Ruby. The basic syntax looks like the
love child of HCL and Chef's recipe DSL and should be immediately familiar
to anyhone who has worked with either of them.

TODO

### Known quirks

TODO

## License & Authors

```text
Copyright 2018 Ole Claussen

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
