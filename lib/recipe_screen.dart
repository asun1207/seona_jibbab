import 'package:flutter/material.dart';
import 'package:jibbab_app/recipe_model.dart';
import 'package:jibbab_app/recipe_detail_screen.dart';

class RecipeScreen extends StatefulWidget {
  final String? initialFilter;

  const RecipeScreen({super.key, this.initialFilter});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  late String _selectedFilter;
  final List<String> _filters = ['전체', '한식', '양식', '중식', '일식', '10분이내'];

  // 🌟 검색을 위한 상태 변수 추가
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialFilter ?? '전체';
  }

  @override
  void dispose() {
    _searchController.dispose(); // 메모리 누수 방지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1D9E75);

    // 🌟 1단계: 카테고리 필터링 + 2단계: 검색어 필터링을 동시에 적용
    List<Recipe> filteredRecipes = allRecipes.where((r) {
      // 1. 카테고리 체크
      bool categoryMatch = true;
      if (_selectedFilter != '전체') {
        if (_selectedFilter == '10분이내') {
          categoryMatch = (r.time == '5분' || r.time == '10분');
        } else {
          categoryMatch = (r.category == _selectedFilter);
        }
      }

      // 2. 검색어 체크 (레시피 이름이나 재료명에 검색어가 포함되어 있는지 확인)
      bool searchMatch = true;
      if (_searchQuery.isNotEmpty) {
        searchMatch = r.name.contains(_searchQuery) ||
            r.ingredients.any((ing) => ing['name']!.contains(_searchQuery));
      }

      return categoryMatch && searchMatch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('레시피', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // 🌟 검색바 영역
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                // 글자가 입력될 때마다 화면 새로고침
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: '어떤 재료가 있나요? (예: 계란, 스팸)',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: primaryColor),
                // 검색어가 있을 때만 'X' 버튼 표시
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.grey),
                  onPressed: () {
                    // X 버튼 누르면 검색창 초기화
                    setState(() {
                      _searchController.clear();
                      _searchQuery = '';
                    });
                  },
                )
                    : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: primaryColor, width: 1.5)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: primaryColor, width: 2.0)),
              ),
            ),
          ),

          // 필터 칩 영역
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
                    selectedColor: primaryColor,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: isSelected ? primaryColor : Colors.grey.shade300),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('총 ${filteredRecipes.length}건', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const Text('맛있었어요순 ▼', style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          // 🌟 레시피 리스트 (검색 결과가 없을 때의 처리 추가)
          Expanded(
            child: filteredRecipes.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('텅~ 🍳', style: TextStyle(fontSize: 40, color: Colors.grey.shade400)),
                  const SizedBox(height: 16),
                  const Text('조건에 맞는 레시피가 없어요.', style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            )
                : ListView.builder(
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = filteredRecipes[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecipeDetailScreen(recipe: recipe)),
                    );
                  },
                  child: _buildRecipeListItem(recipe),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeListItem(Recipe recipe) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE)))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 80, height: 80, decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)), child: Center(child: Text(recipe.emoji, style: const TextStyle(fontSize: 40)))),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipe.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)), child: Text(recipe.category, style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontWeight: FontWeight.bold))),
                    const SizedBox(width: 6),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3), decoration: BoxDecoration(color: const Color(0xFF1D9E75).withOpacity(0.1), borderRadius: BorderRadius.circular(4)), child: Text(recipe.difficulty, style: const TextStyle(fontSize: 11, color: Color(0xFF1D9E75), fontWeight: FontWeight.bold))),
                  ],
                ),
                const SizedBox(height: 8),
                Text('재료 ${recipe.ingredientCount}개 · 조리시간 ${recipe.time}', style: const TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 4),
                Row(children: [const Icon(Icons.favorite, size: 14, color: Color(0xFF1D9E75)), const SizedBox(width: 4), Text('${recipe.likes}명이 맛있어했어요', style: const TextStyle(fontSize: 12, color: Colors.black87))]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}