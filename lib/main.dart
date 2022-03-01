import 'package:flutter/material.dart';
import 'recipe.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({Key? key}) : super(key: key);

  //1. build()是widget的入口方法，在该方法内将可以组合其他widget来形成一个新的widget
  @override
  Widget build(BuildContext context) {
    //2. 主题决定了APP的外观样式，默认主题是Material
    final ThemeData theme = ThemeData();
    //3. MaterialApp 使用了 Material Design，并被用来构造RecipeApp
    return MaterialApp(
      //4. 这个title不会显示在UI上，只是设备用来区分APP的一个描述
      title: 'Recipe Calculator',
      //5. 在此更改APP主题颜色
      theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
        primary: Colors.grey,
        secondary: Colors.black,
      )),
      //6. 使用MyHomePage 类来展示具体的UI，这里的title会展示在APP标题栏上
      home: const MyHomePage(title: 'Recipe Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //1.Scaffold是UI的顶层结构
    return Scaffold(
      //2.APPBar展示了在MyHomePage(title: 'Recipe Calculator')传入的标题
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //3.SafeArea防止应用程序太接近操作系统界面
      body: SafeArea(
        //4.主UI，使用ListView创建一个列表
        child: ListView.builder(
          //5.列表的行数
          itemCount: Recipe.samples.length,
          //6.列表中每一行所展示的UI
          itemBuilder: (BuildContext context, int index) {
            //7.用GestureDetector来替换一个Card，顾名思义，它可以处理手势相关问题
            return GestureDetector(
              //8.实现onTap方法，它在Widget被点击时被回调
              onTap: () {
                //9.路由方法，后面将会了解更多
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      //10.路由指向的界面，目前只是一个简单地Text，后面我们将添加一个详情界面
                      //TODO: Replace return with return RecipeDetail()
                      return const Text('Detail page');
                    },
                  ),
                );
              },
              //11.GestureDetector’s child的属性定义了手势交互的区域，就是之前的Card
              child: buildRecipeCard(Recipe.samples[index]),
            );
          },
        ),
      ),
    );
  }

  Widget buildRecipeCard(Recipe recipe) {
    return Card(
      //1.Z轴上widget的位置，控制了Card下面的阴影效果
      elevation: 2.0,
      //2.Card的shape
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //3.Column里垂直方向上放置了Image和Text
          children: <Widget>[
            Image(image: AssetImage(recipe.imageUrl)),
            //4.在image和text之间加入了一个空白的填充空间
            const SizedBox(height: 14.0),
            //5.为Text定制了样式
            Text(
              recipe.label,
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Palatino'),
            )
          ],
        ),
      ),
    );
  }
}
