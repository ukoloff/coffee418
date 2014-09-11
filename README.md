#coffee418

Browserify + Coffeeify + Uglify + Watchify

# Usage

```sh
npm init
npm install coffee418 --save-dev
```

Replace the following lines in `package.json`
```json
  "scripts": {
    "test": "node node_modules/coffee418"
  }
```
Add link to main file into `package.json`
```json
  },
  "browser": "src/main"
```

then run
```sh
npm test [--once]
```

## Credits

  * [Browserify](http://browserify.org/)
  * [CoffeeScript](http://coffeescript.org/)
  * [UglifyJS](https://github.com/mishoo/UglifyJS2)
  * [Hyper Text Coffee Pot Control Protocol](https://ru.wikipedia.org/wiki/HTCPCP)
