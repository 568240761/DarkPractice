var name1 = 'Jack';
//name 变量的类型被推断为 String，也可以为其指定类型。
String name2 = 'Jack';
//如果变量不局限于单一的类型，可以指定为 Object 或 dynamic 类型。
dynamic name3 = 'Jack';
Object name4 = 'Jack';

main() {
  print(name1);

  print(name2);

  name3 = 30;
  print(name3);

  name4 = true;
  print(name4);

  int lineCount;
  if (lineCount == null) {
    print("默认值为空");
  }

  final name = 'Bob';
  final String nickname = 'Bobby';
  //final 变量只可以被赋值一次
  //name ="Jack";

  //也可以将构造函数声明为 const 的，这种类型的构造函数创建的对象是不可改变的。
  var foo = const [];
  final bar = const [];
  var bab = [1, 2, 3, 4, 5];
  const baz = [2, 4]; // 这种情况下，[] 相当于 const []。
  const bay = const [3, 5, 8];

  foo = [1, 2, 3];

  //没有使用 final 或 const 修饰的变量的值是可以被更改的，baz 是用 const 修饰的不可以修改。
  //baz = [2];

  bab[1] = 9;
  print(bab);

  //这会抛出异常（Unsupported operation: Cannot modify an unmodifiable list），
  //因为用 const 声明的构造函数其对象是不可以修改的。
  //bay[1] = 4;
  print(bay);

  const Object i = 3;

  const list = [i as int];
  print(list);

  const map = {if (i is int) i: "int"};
  print(map);

  const set = {if (list is List<int>) ...list};
  print(set);
}
