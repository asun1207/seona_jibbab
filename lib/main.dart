import 'package:flutter/material.dart';

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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D9E75),
        elevation: 0,
        title: const Text(
          '집밥의민족',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2. 배너 섹션
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: const Color(0xFFEAF3DE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '오늘도 해먹자!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D9E75),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '배달비 아끼고 장바구니 가볍게',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),

            // 3. 카테고리 아이콘 행
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryItem('🍱', '한식'),
                  _buildCategoryItem('🍝', '양식'),
                  _buildCategoryItem('🇨🇳', '중식'),
                  _buildCategoryItem('🍣', '일식'),
                  _buildCategoryItem('⏱️', '10분이내'),
                ],
              ),
            ),

            const Divider(thickness: 8, color: Color(0xFFF5F5F5)),

            // 4. 오늘의 추천 섹션 타이틀
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Text(
                '오늘의 추천',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // 5. 레시피 카드 리스트
            _buildRecipeList(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      // 6. 하단 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1D9E75),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: '레시피'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer_outlined), label: '할인정보'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '마이페이지'),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String emoji, String title) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 30)),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 13, color: Colors.black87)),
      ],
    );
  }

  Widget _buildRecipeList() {
    final recipes = [
      {'emoji': '🍳', 'name': '간단 간장계란밥', 'ingredients': 4, 'time': '5분', 'likes': 1250, 'badge': '간단'},
      {'emoji': '🥘', 'name': '얼큰 차돌된장찌개', 'ingredients': 8, 'time': '20분', 'likes': 890, 'badge': '추천'},
      {'emoji': '🍝', 'name': '원팬 토마토 파스타', 'ingredients': 6, 'time': '15분', 'likes': 2100, 'badge': '인기'},
      {'emoji': '🥗', 'name': '닭가슴살 오리엔탈 샐러드', 'ingredients': 5, 'time': '10분', 'likes': 450, 'badge': '다이어트'},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return Container(
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
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Text(recipe['emoji'] as String, style: const TextStyle(fontSize: 40))),
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
                          decoration: BoxDecoration(
                            color: const Color(0xFF1D9E75).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            recipe['badge'] as String,
                            style: const TextStyle(fontSize: 10, color: Color(0xFF1D9E75), fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(recipe['name'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('재료 ${recipe['ingredients']}개 · 조리시간 ${recipe['time']}', style: const TextStyle(fontSize: 13, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.favorite, size: 14, color: Color(0xFF1D9E75)),
                        const SizedBox(width: 4),
                        Text('${recipe['likes']}명이 맛있어했어요', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}