import 'package:flutter/material.dart';
import 'package:jibbab_app/recipe_detail_screen.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  // 필터 칩 상태 관리
  String _selectedFilter = '전체';
  final List<String> _filters = ['전체', '10분이내', '재료3개이하', '초보가능', '냉장고털기'];

  // 정렬 옵션 상태 관리
  String _selectedSort = '맛있었어요순';

  // 8개의 하드코딩된 레시피 데이터 (다양한 카테고리)
  final List<Map<String, dynamic>> _recipes = [
    {
      'emoji': '🍳',
      'name': '간장계란밥',
      'category': '한식',
      'difficulty': '간단',
      'ingredients': 3,
      'time': '5분',
      'likes': 1250,
    },
    {
      'emoji': '🍝',
      'name': '원팬 토마토 파스타',
      'category': '양식',
      'difficulty': '간단',
      'ingredients': 6,
      'time': '15분',
      'likes': 2100,
    },
    {
      'emoji': '🥡',
      'name': '초간단 마파두부 덮밥',
      'category': '중식',
      'difficulty': '보통',
      'ingredients': 7,
      'time': '15분',
      'likes': 890,
    },
    {
      'emoji': '🥘',
      'name': '차돌박이 된장찌개',
      'category': '한식',
      'difficulty': '보통',
      'ingredients': 8,
      'time': '20분',
      'likes': 1560,
    },
    {
      'emoji': '🥗',
      'name': '연어 간장 포케',
      'category': '일식',
      'difficulty': '간단',
      'ingredients': 5,
      'time': '10분',
      'likes': 730,
    },
    {
      'emoji': '🍲',
      'name': '손님맞이 밀푀유나베',
      'category': '일식',
      'difficulty': '어려움',
      'ingredients': 9,
      'time': '30분',
      'likes': 3200,
    },
    {
      'emoji': '🍤',
      'name': '감바스 알 아히요',
      'category': '양식',
      'difficulty': '보통',
      'ingredients': 5,
      'time': '15분',
      'likes': 950,
    },
    {
      'emoji': '🥓',
      'name': '스팸 김치볶음밥',
      'category': '한식',
      'difficulty': '간단',
      'ingredients': 4,
      'time': '10분',
      'likes': 4500,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '레시피',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // 2. 검색바
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '어떤 재료가 있나요?',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF1D9E75)),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF1D9E75),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF1D9E75),
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),

          // 3. 필터 칩 행
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: _filters.map((filter) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    selectedColor: const Color(0xFF1D9E75),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? const Color(0xFF1D9E75)
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          // 4. 정렬 옵션 및 건수
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '총 ${_recipes.length}건',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedSort,
                    icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    items: ['맛있었어요순', '빠른순', '재료적은순'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSort = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          // 5. 레시피 리스트
          Expanded(
            child: ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                final recipe = _recipes[index];
                return _buildRecipeListItem(recipe);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 레시피 목록 아이템 위젯
  Widget _buildRecipeListItem(Map<String, dynamic> recipe) {
    return InkWell(
      onTap: () {
        // 클릭 시 상세 화면으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RecipeDetailScreen()),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이모지 썸네일
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  recipe['emoji'],
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // 상세 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _buildBadge(
                        recipe['category'],
                        Colors.grey.shade600,
                        Colors.grey.shade100,
                      ),
                      const SizedBox(width: 6),
                      _buildBadge(
                        recipe['difficulty'],
                        recipe['difficulty'] == '간단'
                            ? const Color(0xFF1D9E75)
                            : Colors.orange,
                        recipe['difficulty'] == '간단'
                            ? const Color(0xFF1D9E75).withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '재료 ${recipe['ingredients']}개 · 조리시간 ${recipe['time']}',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite,
                        size: 14,
                        color: Color(0xFF1D9E75),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${recipe['likes']}명이 맛있어했어요',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
