import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learn_shan/utilities/utils.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  final String categoryId;
  late List<String> categoryIds; // NEW: The specific list for this category

  DetailScreen({super.key, required this.id, required this.categoryId}) {
    categoryIds = definitions[categoryId]!.keys.toList();
    print("Category ID: $categoryId\nID: $id");
  }

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final AudioPlayer _player = AudioPlayer();

  late String _currentId;
  late Definition _definition;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentId = widget.id;
    _loadData();
  }

  void _loadData() {
    _definition = definitions[widget.categoryId]![_currentId]!;
    // Now we use the passed categoryIds instead of all definitions
    _currentIndex = widget.categoryIds.indexOf(_currentId);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _updateContent(int index) {
    if (index >= 0 && index < widget.categoryIds.length) {
      setState(() {
        _currentId = widget.categoryIds[index];
        _loadData();
      });
    }
  }

  // --- UI Helpers ---

  Future<void> _playShanSound(String text) async {
    String fileName = transliterateShan(text.substring(0, 1));
    await _player.play(AssetSource('audios/$fileName.m4a'));
  }

  TextStyle _ajStyle({
    double size = 16,
    FontWeight weight = FontWeight.normal,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: "AJ",
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Boundary checks for the current category
    final bool isFirst = _currentIndex <= 0;
    final bool isLast = _currentIndex >= widget.categoryIds.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          _definition.id,
          style: _ajStyle(
            size: 24,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: SingleChildScrollView(
          key: ValueKey<String>(_currentId),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      _definition.title,
                      style: _ajStyle(size: 24, weight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blueAccent.withOpacity(0.1),
                        ),
                      ),
                      child: Text(
                        _definition.description,
                        textAlign: TextAlign.center,
                        style: _ajStyle(size: 15, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),
              _buildSection("တူဝ်ယၢင်ႇတႅမ်ႈ (Spelling)", Icons.edit),
              Wrap(
                children: _definition.spelling
                    .map((text) => _buildChip(text))
                    .toList(),
              ),
              _buildSection("လၢႆးၸႂ်ႉတိုဝ်း (Examples)", Icons.menu_book),
              ..._definition.usages.map(
                (text) => _buildExampleTile(text, _definition.isPlayable),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(isFirst, isLast),
    );
  }

  // --- Sub-Widgets for the Build Method ---

  Widget _buildBottomNav(bool isFirst, bool isLast) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navButton(
            label: "ဢွၼ်ႇၼႃႈ",
            icon: Icons.arrow_back_ios_new_rounded,
            isDisabled: isFirst,
            onTap: () => _updateContent(_currentIndex - 1),
          ),
          // Shows progress within the category: e.g., 5 / 34
          Text(
            "${_currentIndex + 1} / ${widget.categoryIds.length}",
            style: _ajStyle(size: 14, color: Colors.grey),
          ),
          _navButton(
            label: "တၢင်းၼႃႈ",
            icon: Icons.arrow_forward_ios_rounded,
            isDisabled: isLast,
            isNext: true,
            onTap: () => _updateContent(_currentIndex + 1),
          ),
        ],
      ),
    );
  }

  Widget _navButton({
    required String label,
    required IconData icon,
    required bool isDisabled,
    required VoidCallback onTap,
    bool isNext = false,
  }) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      child: Opacity(
        opacity: isDisabled ? 0.2 : 1.0,
        child: Row(
          children: [
            if (!isNext) Icon(icon, size: 18, color: Colors.blueAccent),
            const SizedBox(width: 8),
            Text(
              label,
              style: _ajStyle(
                size: 16,
                weight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            if (isNext) const SizedBox(width: 8),
            if (isNext) Icon(icon, size: 18, color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.blueAccent),
          const SizedBox(width: 8),
          Text(
            label,
            style: _ajStyle(
              size: 14,
              weight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Text(text, style: _ajStyle(size: 18, weight: FontWeight.w500)),
    );
  }

  Widget _buildExampleTile(String text, bool isPlayable) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(text, style: _ajStyle(size: 17)),
        trailing: isPlayable
            ? IconButton(
                onPressed: () => _playShanSound(text),
                icon: const FaIcon(
                  FontAwesomeIcons.volumeHigh,
                  size: 18,
                  color: Colors.blueAccent,
                ),
              )
            : null,
      ),
    );
  }
}
