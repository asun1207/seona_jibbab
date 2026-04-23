import 'package:flutter/material.dart';
import 'package:jibbab_app/recipe_model.dart';
import 'package:jibbab_app/recipe_detail_screen.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('레시피', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), backgroundColor: Colors.white, elevation: 0),
      body: Column(
        children: [
          // (검색바, 필터 칩 등 기존 UI 코드는 그대로 유지...)
          Expanded(
            child: ListView.builder(
              itemCount: allRecipes.length, // 데이터 개수만큼 생성
              itemBuilder: (context, index) {
                final recipe = allRecipes[index];
                return InkWell(
                  onTap: () {
                    // 👉 클릭한 레시피 객체를 상세 화면으로 전달!
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
        children: [
          Container(width: 80, height: 80, decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)), child: Center(child: Text(recipe.emoji, style: const TextStyle(fontSize: 40)))),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipe.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('${recipe.category} · ${recipe.difficulty}', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.favorite, size: 14, color: Color(0xFF1D9E75)),
                    const SizedBox(width: 4),
                    Text('${recipe.likes}명이 맛있어했어요', style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}