import 'package:flutter_storyblok/widgets.dart';
import 'package:test/test.dart';

void main() {
  group('Test parsing colors from storyblok', () {
    test('Test parse color hexadecimal', () {
      final color = StoryblokColor.fromString("#FF8800");
      expect((color.a * 255).round(), 0xFF);
      expect((color.r * 255).round(), 0xFF);
      expect((color.g * 255).round(), 0x88);
      expect((color.b * 255).round(), 0x00);
    });

    test('Test parse color css', () {
      final color = StoryblokColor.fromString("rgb(255, 136, 0)");
      expect((color.a * 255).round(), 0xFF);
      expect((color.r * 255).round(), 255);
      expect((color.g * 255).round(), 136);
      expect((color.b * 255).round(), 0);
    });
  });
}
