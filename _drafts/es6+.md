JavaScript has a boolean type, with possible values  `true`  and  `false`  (both of which are keywords.) Any value can be converted to a boolean according to the following rules:

1. `false`,  `0`, empty strings (`""`),  `NaN`  `null` and  `undefined`  all become  `false.`
2. All other values become  `true.`

You can perform this conversion explicitly using the  `Boolean()`  function:

```js
Boolean('');  // false
Boolean(234); // true
```

However, this is rarely necessary, as JavaScript will silently perform this conversion when it expects a Boolean, such as in an `if` statement (see below).

**`let`** allows you to declare block-level variables. The declared variable is available from the _block_ it is enclosed in.

`**const**` allows you to declare variables whose values are never intended to change. The variable is available from the _block_ it is declared in.

`**var**` is the most common declarative keyword. It does not have the restrictions that the other two keywords have. This is because it was traditionally the only way to declare a variable in JavaScript. A variable declared with the **`var`** keyword is available from the written out _function_ (as opposed to an anonymous function) it is declared in.

An important difference between JavaScript and other languages like Java is that in JavaScript, blocks do not have scope; only functions have a scope. So if a variable is defined using  `var`  in a compound statement (for example inside an  `if`  control structure), it will be visible to the entire function. However, starting with ECMAScript 2015,  `[let](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/let)`  and  `[const](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/const)`  declarations allow you to create block-scoped variables.

There are two basic ways to create an empty object:

```js
var obj = new Object();
```

And:

```js
var obj = {};
```

These are semantically equivalent; the second is called object literal syntax and is more convenient. This syntax is also the core of JSON format and should be preferred at all times.

---

[https://developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript)

---
