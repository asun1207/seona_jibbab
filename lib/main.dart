import 'package:flutter/material.dart';
import 'package:jibbab_app/recipe_model.dart'; // 🌟 새로 만든 레시피 데이터 모델 불러오기
import 'package:jibbab_app/recipe_detail_screen.dart'; // 🌟 레시피 상세 화면 불러오기
import 'package:jibbab_app/recipe_screen.dart';
import 'package:jibbab_app/discount_screen.dart';
import 'package:jibbab_app/my_page_screen.dart';

void main() {
  runApp(const JibbabMinjokApp());
}

class JibbabMinjokApp extends StatelessWidget {
  const JibbabMinjokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1D9E75),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),      // 0번: 홈 화면
    const RecipeScreen(),    // 1번: 레시피 화면
    const DiscountScreen(), // 2번: 할인 정보 화면
    const MyPageScreen(), // 3번: 마이 페이지 화면
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1D9E75),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: '레시피'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer_outlined), label: '할인정보'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '마이페이지'),
        ],
      ),
    );
  }
}

// 🌟 여기서부터 인터랙션이 추가된 새로운 홈 화면입니다!
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1D9E75);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text(
          '집밥의민족',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: false,
        actions: [
          IconButton(icon: const Icon(Icons.location_on_outlined, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 배너 섹션
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: const Color(0xFFEAF3DE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('오늘도 해먹자!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor)),
                  SizedBox(height: 8),
                  Text('배달비 아끼고 장바구니 가볍게', style: TextStyle(fontSize: 14, color: Colors.black54)),
                ],
              ),
            ),

            // 🌟 1. 카테고리 아이콘 행 (클릭하면 필터 넘기면서 레시피 목록으로 이동)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryItem(context, '🍚', '한식'),
                  _buildCategoryItem(context, '🍝', '양식'),
                  _buildCategoryItem(context, '🥡', '중식'),
                  _buildCategoryItem(context, '🍣', '일식'),
                  _buildCategoryItem(context, '⏱️', '10분이내'),
                ],
              ),
            ),

            const Divider(thickness: 8, color: Color(0xFFF5F5F5)),

            // 🌟 3. "오늘의 추천" 타이틀 & "더보기" 버튼
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('오늘의 추천', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      // 더보기 클릭 시 필터 없이 레시피 전체 목록으로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RecipeScreen(initialFilter: '전체')),
                      );
                    },
                    child: const Text('더보기 >', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            // 🌟 2. 추천 레시피 카드 리스트 (클릭하면 상세 화면으로 이동)
            _buildRecommendedRecipeList(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // 카테고리 아이콘 클릭 위젯
  Widget _buildCategoryItem(BuildContext context, String emoji, String filterName) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipeScreen(initialFilter: filterName)),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 8),
            Text(filterName, style: const TextStyle(fontSize: 13, color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  // 추천 레시피 리스트 렌더링 (하드코딩 삭제, recipe_model 연동)
  Widget _buildRecommendedRecipeList(BuildContext context) {
    // allRecipes 리스트에서 상위 4개만 추천으로 뽑아옵니다.
    final recommendRecipes = allRecipes.take(4).toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recommendRecipes.length,
      itemBuilder: (context, index) {
        final recipe = recommendRecipes[index];
        return InkWell(
          onTap: () {
            // 레시피 카드 클릭 시 상세 화면으로 이동 (데이터 전달)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecipeDetailScreen(recipe: recipe)),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Row(
              children: [
                Container(
                  width: 70, height: 70,
                  decoration: BoxDecoration(color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(8)),
                  child: Center(child: Text(recipe.emoji, style: const TextStyle(fontSize: 40))),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: const Color(0xFF1D9E75).withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                            child: Text(recipe.difficulty, style: const TextStyle(fontSize: 10, color: Color(0xFF1D9E75), fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 8),
                          Text(recipe.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text('재료 ${recipe.ingredientCount}개 · 조리시간 ${recipe.time}', style: const TextStyle(fontSize: 13, color: Colors.grey)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.favorite, size: 14, color: Color(0xFF1D9E75)),
                          const SizedBox(width: 4),
                          Text('${recipe.likes}명이 맛있어했어요', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}