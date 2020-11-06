# Dart 学习
当前 SDK 版本为2.9.2，Dart 文档可浏览[官方网站](https://dart.cn/guides/language/language-tour)。

在学习 Dart 语言时, 应该牢记以下几点：
- 所有变量引用的都是对象，每个对象都是一个类的实例。数字、函数以及 null 都是对象。所有的类都继承于 Object 类。
- Dart 是强类型语言，但是在声明变量时指定类型是可选的，因为 Dart 可以进行类型推断。如果想显式地声明一个不确定的类型，可以使用特殊类型 dynamic。
- Dart 支持泛型，比如 List<int>（表示一组由 int 对象组成的列表）或 List<dynamic>（表示一组由任何类型对象组成的列表）。
- Dart 支持顶级函数，同时还支持定义属于类或对象的函数（即 Java 中的静态方法 和 实例方法）。还可以在函数中定义函数（嵌套 或 局部函数）。
- Dart 支持顶级变量，以及定义属于类或对象的变量（静态和实例变量）。实例变量有时称之为域或属性。
- Dart 没有类似于 Java 那样的 public、protected 和 private 成员访问限定符。如果一个标识符以下划线 (_) 开头则表示该标识符在库内是私有的。
- Dart 中表达式和语句是有区别的，表达式有值而语句没有。
- Dart 工具可以显示警告和错误两种类型的问题。警告表明代码可能有问题但不会阻止其运行。错误分为编译时错误和运行时错误；编译时错误代码无法运行；运行时错误会在代码运行时导致异常。

## 变量
创建一个变量并将其初始化,可以使用以下方式：
```dart
var name = 'Jack';
//name 变量的类型被推断为 String，也可以为其指定类型。
String name = 'Jack';
//如果变量不局限于单一的类型，可以指定为 Object 或 dynamic 类型。
dynamic name = 'Jack';
Object name = 'Jack';
```
### 默认值
在 Dart 中，未初始化的变量拥有一个默认的初始化值：null。即便数字也是如此，因为在 Dart 中一切皆为对象，数字也不例。
```dart
int lineCount;
main(){
  assert(lineCount == null);
}
```
注意：assert() 的调用将会在生产环境的代码中被忽略掉。在开发过程中，assert(condition) 将会在 条件判断 为 false 时抛出一个异常。
### Final 和 Const
当不想更改一个变量，可以使用关键字 final 或者 const 修饰变量，这两个关键字可以替代 var 关键字或者加在一个具体的类型前。

final 变量只可以被赋值一次。顶层的 final 变量或者类的 final 变量在其第一次使用的时候被初始化。

const 变量是一个编译时常量（const 变量同时也是 final 的）。使用 const 修饰类中的变量，则必须加上 static 关键字，即 static const（注意：顺序不能颠倒）。在声明 const 变量时可以直接为其赋值，也可以使用其它的 const 变量为其赋值。也可以将构造函数声明为 const 的，这种类型的构造函数创建的对象是不可改变的。

实例变量可以是 final 的但不可以是 const 的， final 实例变量必须在构造器开始前被初始化，比如在声明实例变量时初始化，或者作为构造器参数，或者将其置于构造器的初始化列表中。

从 Dart 2.5 开始，你可以在常量中使用类型检查和强制类型转换 (is and as)、collection if 以及 spread operators (... and ...?)：
```dart
const Object i = 3;
const list = [i as int];
const map = {if (i is int) i: "int"}; 
const set = {if (list is List<int>) ...list};
```
## 内置类型
支持如下列类型：
- Numbers
- Strings
- Runes
- Booleans
- Lists
- Sets
- Maps
- Symbols
### Numbers
Dart 有两种 Number 类型；int（整数值）和double（浮点数）。

int，整数值；长度不超过 64位，具体取值范围依赖于不同的平台。取值范围可查看[官方文档](https://dart.cn/guides/language/language-tour#numbers)。

double，64位的双精度浮点数字，且符合 IEEE 754 标准。

int 和 double 都是 num 的子类。 num 中定义了一些基本的运算符比如 +、-、*、/ 等，还定义了 abs()、ceil() 和 floor() 等方法。如果 num 及其子类不满足你的要求，可以查看 dart:math 库中的 API。
```dart
// String -> int
var one = int.parse('1');

// String -> double
var onePointOne = double.parse('1.1');

// int -> String
String oneAsString = 1.toString();

// double -> String
String piAsString = 3.14159.toStringAsFixed(2);
```
整型支持传统的位移操作，比如移位（<<、>>）、按位与（&）、按位或（|），如下：
```dart
var i = 3 << 1; // 0011 << 1 = 0110
var j = 3 >> 1; // 0011 >> 1 = 0001
var k = 3 | 4; // 0011 | 0100 = 0111
```
### [Strings](https://dart.cn/guides/language/language-tour#strings)
Dart 字符串是 UTF-16 编码的字符序列。可以使用单引号或者双引号来创建字符串。
```dart
var s1 = 'It\'s easy to escape the string delimiter.';
var s2 = "It's even easier to use the other delimiter.";
var s3 = '使用单引号创建字符串时可以使用斜杠来转义那些与单引号冲突的字符串：\'。';
var s4 = "而在双引号中则不需要使用转义与单引号冲突的字符串：'";
```
在字符串中以 ${表达式} 的形式使用表达式，如果表达式是一个标识符，可以省略掉 {}。如果表达式的结果为一个对象，则 Dart 会调用该对象的 toString 方法来获取一个字符串。

注意，== 运算符判断两个对象的内容是否一样，如果两个字符串包含一样的字符编码序列，则表示相等。

在字符串前加上 r 作为前缀创建 “raw” 字符串（即不会被做任何处理（比如转义）的字符串）：
```dart
var s = r'在 raw 字符串中，转义字符串 \n 会直接输出 “\n” 而不是转义为换行。';
```
[字符和正则表达式](https://dart.cn/guides/libraries/library-tour#strings-and-regular-expressions),可查看官方文档。
### Runes
在 Dart 中，runes 公开了字符串的 Unicode 码位。从 Dart 2.6 开始，使用 characters 包来访问或者操作用户感知的字符。

Unicode 编码为每一个字母、数字和符号都定义了一个唯一的数值。因为 Dart 中的字符串是一个 UTF-16 的字符序列，所以如果想要表示 32 位的 Unicode 数值则需要一种特殊的语法。

通常使用 \uXXXX 来表示 Unicode 字符， XXXX 是一个四位数的 16 进制数字。例如心形字符（♥）的 Unicode 为 \u2665。对于不是四位数的 16 进制数字，需要使用大括号将其括起来。例如大笑的 emoji 表情（😆）的 Unicode 为 \u{1f600}。

如果你需要读写单个 Unicode 字符，可以使用 characters 包中定义的 characters getter。如下：
```dart
import 'package:characters/characters.dart';

main(){
  var hi = 'Hi 🇩🇰';
  print(hi);
  print('The end of the string: ${hi.substring(hi.length - 1)}');
  print('The last character: ${hi.characters.last}\n');
}
```
### Booleans
Dart 使用 bool 关键字表示布尔类型，布尔类型只有两个对象 true 和 false，两者都是编译时常量。
### Lists
在 Dart 中数组由 List 对象表示。
```dart
//推断出 list 的类型为 List<int>，如果往该数组中添加一个非 int 类型的对象则会报错。
var list = [1, 2, 3];
```
Dart 在 2.3 引入了扩展操作符（...）和 null-aware 扩展操作符（...?），它们提供了一种将多个元素插入集合的简洁方法。
```dart
var list = [1, 2, 3];
var list2 = [0, ...list];

var list3;
//如果扩展操作符右边可能为 null ，你可以使用 null-aware 扩展操作符（...?）来避免产生异常
var list4 = [0, ...?list3];
```
Dart 在 2.3 还引入了 Collection If 和 Collection For，在构建集合时，可以使用条件判断（if）和循环（for）。
```dart
var nav = [
  'Home',
  'Furniture',
  'Plants',
  if (promoActive) 'Outlet'
];

var listOfInts = [1, 2, 3];
var listOfStrings = [
  '#0',
  for (var i in listOfInts) '#$i'
];
```

### Sets
在 Dart 中，Set 是一组特定元素的无序集合。尽管 Set 类型是 Dart 的一项核心功能，但是 Set 字面量却是在 Dart2.2 中才加入的。
```dart
//推断 halogens 变量是一个 Set<String> 类型的集合，如果往该 Set 中添加类型不正确的对象则会报错。
var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};

var names = <String>{}; // 类型+{}的形式创建 Set。
Set<String> names = {}; // 声明类型变量的形式创建 Set 
var names = {}; // 这样的形式将创建一个 Map 而不是 Set
//因为先有的 Map 字面量语法，所以 {} 默认是 Map 类型。
//如果忘记在 {} 上注释类型或赋值到一个未声明类型的变量上，
//那么 Dart 会创建一个类型为 Map<dynamic, dynamic> 的对象。
```
向一个已存在的 Set 中添加项目可以使用 add() 方法或 addAll() 方法。

从 Dart 2.3 开始，Set 可以像 List 一样支持使用扩展操作符（... 和 ...?）以及 Collection If 和 Collection For 操作。
### Maps
Map 是用来关联 keys 和 values 的对象。 keys 和 values 可以是任何类型的对象。在一个 Map 对象中一个 key 只能出现一次。但是 value 可以出现多次。
```dart
var gifts = {
  'first': 'partridge',
  'second': 'turtledoves',
  'fifth': 'golden rings'
};

var nobleGases = {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};

main(){
  var gifts = Map();
  gifts['first'] = 'partridge';
  gifts['second'] = 'turtledoves';
  gifts['fifth'] = 'golden rings';

  var nobleGases = Map();
  nobleGases[2] = 'helium';
  nobleGases[10] = 'neon';
  nobleGases[18] = 'argon';
}
```
如果检索的 Key 不存在于 Map 中则会返回一个 null。

从 Dart 2.3 Map 可以像 List 一样支持使用扩展操作符（... 和 ...?）以及 Collection If 和 Collection For 操作。
### Symbols
Symbol 表示 Dart 中声明的操作符或者标识符，该类型的对象几乎不会被使用到，但是如果需要按名称引用它们的 API 时就非常有用。因为代码压缩后会改变这些符号的名称但不会改变具体的符号。

可以使用在标识符前加 # 前缀来获取 Symbol：
```
//Symbol 字面量是编译时常量。
#bar
```
## 函数
在 Dart 中，函数也是对象并且类型为 Function。

定义一个函数的例子：
```dart
bool isNoble(int atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}

//如果函数体内只包含一个表达式，可以使用简写语法：
bool isNoble(int atomicNumber) => _nobleGases[atomicNumber] != null;
//注意，在 => 与 ; 之间的只能是 表达式 而非 语句。
```

### 函数参数
函数可以有两种形式的参数：必要参数和可选参数。必要参数定义在参数列表前面，可选参数则定义在必要参数后面。

可选参数分为命名参数和位置参数，可在参数列表中任选其一使用，但两者不能同时出现在参数列表中。
#### 命名参数
定义函数时，使用 {param1, param2, …} 来指定命名参数，可以使用 @required 注解来标识一个命名参数是必须的参数，此时调用者则必须为该参数提供一个值。@required 注解定义在 meta 包中，可以直接导入 package:meta/meta.dart 包使用。
```dart
void enableFlags({bool bold, @required bool hidden}) {}

//当调用函数时，可以使用 参数名: 参数值 的形式来指定命名参数
main(){
  enableFlags(bold:true, hidden:false);
}
```
#### 位置参数
定义函数时，使用 [param1, param2, …] 将一系列参数包裹起来作为位置参数；
```dart
String say(String from, String msg, [String device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}
```

可以用 = 为函数的命名和位置参数定义默认值，默认值必须为编译时常量，没有指定默认值的情况下默认值为 null。
### [main() 函数](https://dart.cn/guides/language/language-tour#the-main-function)
### 函数作为一级对象
可以将函数作为参数传递给另一个函数，也可以将函数赋值给一个变量。
```dart
void printElement(int element) {
  print(element);
}

main(){
  var list = [1, 2, 3];
  
  //将 printElement 函数作为参数传递。
  list.forEach(printElement);

  //将函数赋值给一个变量
  var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
  assert(loudify('hello') == '!!! HELLO !!!');
}
```
### 匿名函数
大多数方法都是有名字的，比如 main() 或 printElement()。可以创建一个没有名字的方法，称之为匿名函数，或 Lambda表达式 或 Closure闭包。
```dart
main(){
  var list = ['apples', 'bananas', 'oranges'];
  list.forEach((item) {
    print('${list.indexOf(item)}: $item');
  });

  //如果函数体内只有一行语句，可以使用胖箭头缩写法。
  list.forEach((item) => print('${list.indexOf(item)}: $item'));
}
```
### [词法作用域](https://dart.cn/guides/language/language-tour#lexical-scope)
在 Dart 中，变量的作用域在写代码的时候就确定了，大括号内定义的变量只能在大括号内访问，与 Java 类似。
```dart
bool topLevel = true;

void main() {
  var insideMain = true;

  void myFunction() {
    var insideFunction = true;

    void nestedFunction() {
      var insideNestedFunction = true;

      assert(topLevel);
      assert(insideMain);
      assert(insideFunction);
      assert(insideNestedFunction);
    }
  }
}
```
### [词法闭包](https://dart.cn/guides/language/language-tour#lexical-closures)
闭包即一个函数对象，即使函数对象的调用在它原始作用域之外，依然能够访问在它词法作用域内的变量。
```dart
Function makeAdder(int addBy) {
  return (int i) => addBy + i;
}

void main() {
  // 生成加 2 的函数。
  var add2 = makeAdder(2);

  // 生成加 4 的函数。
  var add4 = makeAdder(4);

  assert(add2(3) == 5);
  assert(add4(3) == 7);
}
```
### 返回值
所有的函数都有返回值。没有显示返回语句的函数最后一行默认为执行 return null; 。
```dart
foo() {}

main(){
  assert(foo() == null);
}
```
## [运算符](https://dart.cn/guides/language/language-tour#operators)
Dart 中的大多数运算符与 Java 和 Kotlin 相似，就不记录了，详细使用见官方文档。

下面列举在 Java 中没有的运算符。
### ??=
可以使用 ??= 来为值为 null 的变量赋值。
```dart
var b;
main(){
  //当 b 为 null 时才赋值为 5
  b??=5;
}
```
### 表达式 1 ?? 表达式 2
如果表达式 1 为非 null 则返回其值，否则执行表达式 2 并返回其值。
```dart
String playerName(String name) => name ?? 'Guest';
```
### 级联运算符（..）
可以在同一个对象上连续调用多个对象的变量或方法。
```dart
main(){
  //方法 querySelector 返回了一个 Selector 对象，后面的级联操作符都是调用这个 Selector 对象的成员并忽略每个操作的返回值。
  querySelector('#confirm') // 获取对象
    ..text = 'Confirm' // 使用对象的成员
    ..classes.add('important')
    ..onClick.listen((e) => window.alert('Confirmed!'));

  //级联运算符可以嵌套
  final addressBook = (AddressBookBuilder()
        ..name = 'jenny'
        ..email = 'jenny@example.com'
        ..phone = (PhoneNumberBuilder()
              ..number = '415-555-0100'
              ..label = 'home')
            .build())
      .build();
  
  //使用级联运算符需要注意函数的返回值
  var sb = StringBuffer();
  sb.write('foo')
    ..write('bar'); // 出错：void 对象中没有方法 write (Error: method 'write' isn't defined for 'void').
}
```
严格来说 .. 级联操作并非一个运算符而是 Dart 的特殊语法。

### ?.
条件访问成员；与上述成员访问符类似，但是左边的操作对象不能为 null，例如 foo?.bar，如果 foo 为 null 则返回 null ，否则返回 bar。

## [流程控制语句](https://dart.cn/guides/language/language-tour#control-flow-statements)
Dart 中的流程控制语句与 Java 和 Kotlin 相似，就不记录了，详细使用见官方文档。

### Switch 和 Case
Switch 语句在 Dart 中使用 == 来比较整数、字符串或编译时常量，比较的两个对象必须是同一个类型且不能是子类并且没有重写 == 操作符。 枚举类型非常适合在 Switch 语句中使用。

每一个非空的 case 子句都必须有一个 break 语句，也可以通过 continue、throw 或者 return 来结束非空 case 语句。
```dart
main(){
  var command = 'OPEN';
  switch (command) {
    case 'CLOSED':
      executeClosed();
      break;
    case 'PENDING':
      executePending();
      break;
    case 'APPROVED':
      executeApproved();
      break;
    case 'DENIED':
      executeDenied();
      break;
    case 'OPEN':
      executeOpen();
      break;
    default:
      executeUnknown();
  }
}
```
忽略了非空的 case 的 break 语句，因此会产生错误：
```dart
main(){
  var command = 'OPEN';
  switch (command) {
    case 'OPEN':
      executeOpen();
      // 错误: 没有 break
    case 'CLOSED':
      executeClosed();
      break;
  }
}
```
Dart 也支持空的 case 语句，允许其以 fall-through 的形式执行。
```dart
main(){
  var command = 'CLOSED';
  switch (command) {
    case 'CLOSED': // case 语句为空时的 fall-through 形式。
    case 'NOW_CLOSED':
      // case 条件值为 CLOSED 和 NOW_CLOSED 时均会执行该语句。
      executeNowClosed();
      break;
  }
}
```
非空 case 语句中想要实现 fall-through 的形式，可以使用 continue 语句配合 lable 的方式实现:
```dart
main(){
  var command = 'CLOSED';
  switch (command) {
    case 'CLOSED':
      executeClosed();
      continue nowClosed;
      //继续执行标签为 nowClosed 的 case 子句。

    nowClosed:
    case 'NOW_CLOSED':
      // case 条件值为 CLOSED 和 NOW_CLOSED 时均会执行该语句。
      executeNowClosed();
      break;
  }
}
```
每个 case 子句都可以有局部变量且仅在该 case 语句内可见。

### 断言
在开发过程中，可以在条件表达式为 false 时使用 assert(条件, 可选信息)方法来打断代码的执行。
```dart
main(){
  assert(urlString.startsWith('https'),
      'URL ($urlString) should start with "https".');
}
```
assert 的第一个参数可以是值为布尔值的任何表达式。如果表达式的值为 true，则断言成功，继续执行。如果表达式的值为 false，则断言失败，抛出一个 AssertionError 异常。

assert 的第二个参数可以为其添加一个字符串消息。

在生产环境代码中，断言会被忽略，与此同时传入 assert 的参数不被判断。

## 异常
Dart 提供了 Exception 和 Error 两种类型的异常以及它们一系列的子类。在 Dart 中也可以将任何非 null 对象作为异常抛出而不局限于 Exception 或 Error 类型。不建议抛出任何非 null 对象，优秀的代码通常会抛出 Error 或 Exception 类型的异常。
```dart
format(){
  throw FormatException('Expected at least 1 section');
}

llamas(){
  throw 'Out of llamas!';
}
```
与 Java 不同的是，Dart 的所有异常都是非必检异常，方法不一定会声明其所抛出的异常并且你也不会被要求捕获任何异常。

捕获异常可以避免异常继续传递（重新抛出异常除外）。
```dart
main(){
  try {
    breedMoreLlamas();
  } on OutOfLlamasException {
    // 指定异常
    buyMoreLlamas();
  } on Exception catch (e) {
    // 其它类型的异常
    print('Unknown exception: $e');
  } catch (e) {
    // 不指定类型，处理其它全部
    print('Something really unknown: $e');
  }
}
```
如上述代码所示可以使用 on 或 catch 来捕获异常，使用 on 来指定异常类型，使用 catch 来捕获异常对象，两者可同时使用。

可以为 catch 方法指定两个参数，第一个参数为抛出的异常对象，第二个参数为栈信息 StackTrace 对象：
```dart
main(){
  try {
    // ···
  } on Exception catch (e) {
    print('Exception details:\n $e');
  } catch (e, s) {
    print('Exception details:\n $e');
    print('Stack trace:\n $s');
  }
}
```
关键字 rethrow 可以将捕获的异常再次抛出：
```dart
void misbehave() {
  try {
    dynamic foo = true;
    print(foo++); // 运行时错误
  } catch (e) {
    print('misbehave() partially handled ${e.runtimeType}.');
    rethrow; // 允许调用者查看异常。
  }
}

void main() {
  try {
    misbehave();
  } catch (e) {
    print('main() finished handling ${e.runtimeType}.');
  }
}
```
使用 finally 语句来包裹确保不管有没有异常都执行代码，如果没有指定 catch 语句来捕获异常，则在执行完 finally 语句后再抛出异常。
```dart
main(){
  try {
    breedMoreLlamas();
  } finally {
    // 总是清理，即便抛出了异常。
    cleanLlamaStalls();
  }
}
```
## [类](https://dart.cn/guides/language/language-tour#classes)
Dart 是支持基于 mixin 继承机制的面向对象语言，所有对象都是一个类的实例，而所有的类都继承自 Object 类。基于 mixin 的继承意味着每个除 Object 类之外的类都只有一个超类，一个类的代码可以在其它多个类继承中重复使用。 Extension 方法是一种在不更改类或创建子类的情况下向类添加功能的方式。

### 常量构造器
构造函数名之前加 const 关键字，使用相同构造函数相同参数值构造的编译时常量是同一个对象。
```dart
fun main(){
  var a = const ImmutablePoint(1, 1);
  var b = const ImmutablePoint(1, 1);

  assert(identical(a, b)); // 它们是同一个实例 (They are the same instance!)
}
```
根据使用常量上下文的场景，可以省略掉构造函数或字面量前的 const 关键字。
```dart
// 这里有很多 const 关键字
const pointAndLine = const {
  'point': const [const ImmutablePoint(0, 0)],
  'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)],
};
  
// 只需要一个 const 关键字，其它的则会隐式地根据上下文进行关联。
const pointAndLine1 = {
  'point': [ImmutablePoint(0, 0)],
  'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
};
```

### 获取对象的类型
使用 Object 对象的 runtimeType 属性在运行时获取一个对象的类型，该对象类型是 Type 的实例。

### 实例变量
所有未初始化的实例变量其值均为 null。

所有实例变量均会隐式地声明一个 Getter 方法，非 final 类型的实例变量还会隐式地声明一个 Setter 方法。

如果你在声明一个实例变量的时候就将其初始化（而不是在构造函数或其它方法中），那么该实例变量的值就会在对象实例创建的时候被设置，该过程会在构造函数以及它的初始化器列表执行前。

### [构造函数](https://dart.cn/guides/language/language-tour#constructors)

#### 命名式构造函数

可以为一个类声明多个命名式构造函数来表达更明确的意图。
```dart
class Point {
  double x, y;

  // 在构造函数体执行前用于设置 x 和 y 的语法糖。
  Point(this.x, this.y);

  // 命名式构造函数
  Point.origin() {
      x = 0;
      y = 0;
  }
}
```

#### 初始化列表

还可以在构造函数体执行之前初始化实例变量，每个实例变量之间使用逗号分隔。
```dart
class Point {
  double x, y;

  // 使用初始化列表在构造函数体执行前设置实例变量。
  Point.fromJson(Map<String, double> json)
    : x = json['x'],
      y = json['y'] {
    print('In Point.fromJson(): ($x, $y)');
  }
}
```

#### 重定向构造函数
类中的构造函数会调用类中其它的构造函数，该重定向构造函数没有函数体，只需在函数签名后使用（:）指定需要重定向到的其它构造函数即可。

#### 常量构造函数
在类的构造函数前加上 const 关键字并确保所有实例变量均为 final ，常量构造函数创建的实例并不总是常量。

#### 工厂构造函数
使用 factory 关键字标识类的构造函数将会令该构造函数变为工厂构造函数，这将意味着使用该构造函数构造类的实例时并非总是会返回新的实例对象。在工厂构造函数中无法访问 this。

### [方法](https://dart.cn/guides/language/language-tour#methods)

#### Getter 和 Setter
Getter 和 Setter 是一对用来读写对象属性的特殊方法，上面说过实例对象的每一个属性都有一个隐式的 Getter 方法，如果为非 final 属性的话还会有一个 Setter 方法，你可以使用 get 和 set 关键字为额外的属性添加 Getter 和 Setter 方法。
```dart
class Rectangle {
  double left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  // 定义两个计算产生的属性：right 和 bottom。
  double get right => left + width;
  set right(double value) => left = value - width;
  double get bottom => top + height;
  set bottom(double value) => top = value - height;
}

void main() {
  var rect = Rectangle(3, 4, 20, 15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);
}
```

### 抽象类
使用关键字 abstract 标识类可以让该类成为抽象类，抽象类将无法被实例化。抽象类常用于声明接口方法、有时也会有具体的方法实现。如果想让抽象类同时可被实例化，可以为其定义 工厂构造函数。

### [隐式接口](https://dart.cn/guides/language/language-tour#implicit-interfaces)
每一个类都隐式地定义了一个接口并实现了该接口，这个接口包含所有这个类的实例成员以及这个类所实现的其它接口。

一个类可以通过关键字 implements 来实现一个或多个接口并实现每个接口定义的 API。
```dart
// Person 类的隐式接口中包含 greet() 方法。
class Person {
  // _name 变量同样包含在接口中，但它只是库内可见的。
  final _name;

  // 构造函数不在接口中。
  Person(this._name);

  // greet() 方法在接口中。
  String greet(String who) => '你好，$who。我是$_name。';
}

// Person 接口的一个实现。
class Impostor implements Person {
  get _name => '';

  String greet(String who) => '你好$who。你知道我是谁吗？';
}

String greetBob(Person person) => person.greet('小芳');

void main() {
  print(greetBob(Person('小芸')));
  print(greetBob(Impostor()));
}
```
### [扩展一个类](https://dart.cn/guides/language/language-tour#extending-a-class)
可重写方法 、运算符；注意，如果重写 == 操作符，必须也同时重写对象 hashCode 的 Getter 方法。

#### noSuchMethod 方法
如果调用了对象上不存在的方法或实例变量将会触发 noSuchMethod 方法，你可以重写 noSuchMethod 方法来追踪和记录这一行为。

你不能调用一个未实现的方法除非下面其中的一个条件成立：
- 接收方是静态的 dynamic 类型。
- 接收方具有静态类型，定义了未实现的方法（抽象亦可），并且接收方的动态类型实现了 noSuchMethod 方法且具体的实现与 Object 中的不同。

### [Extension 方法](https://dart.cn/guides/language/language-tour#extension-methods)
与 Kotlin 的扩展属性相同。

### [枚举类型](https://dart.cn/guides/language/language-tour#enumerated-types)
枚举类型有如下两个限制：
- 枚举不能成为子类，也不可以 mixin，也不可以实现一个枚举。
- 不能显式地实例化一个枚举类。

### 使用 Mixin 为类添加功能
Mixin 是一种在多重继承中复用某个类中代码的方法模式，使用 with 关键字并在其后跟上 Mixin 类的名字。
```dart
class Musician extends Performer with Musical {
  // ···
}

class Maestro extends Person
    with Musical, Aggressive, Demented {
  Maestro(String maestroName) {
    name = maestroName;
    canConduct = true;
  }
}
```
定义一个类继承自 Object 并且不为该类定义构造函数，这个类就是 Mixin 类，除非你想让该类与普通的类一样可以被正常地使用，否则可以使用关键字 mixin 替代 class 让其成为一个单纯的 Mixin 类。
```dart
mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}
```
可以使用关键字 on 来指定哪些类可以使用该 Mixin 类，比如有 Mixin 类 A，但是 A 只能被 B 类使用，则可以这样定义 A。
```dart
class Musician {
  // ...
}
mixin MusicalPerformer on Musician {
  // ...
}
class SingerDancer extends Musician with MusicalPerformer {
  // ...
}
```
## [泛型](https://dart.cn/guides/language/language-tour#generics)
泛型常用于需要要求类型安全的情况，但是它也会对代码运行有好处：
- 可以更好地帮助代码生成
- 可以减少代码重复

## [库和可见性](https://dart.cn/guides/language/language-tour#libraries-and-visibility)
