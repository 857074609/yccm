// lib/desktop/pages/desktop_home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../models/server_model.dart';

class DesktopHomePage extends StatelessWidget {
  const DesktopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 320,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 蓝色标题栏：远程协助
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                color: const Color(0xFF2F65BA),
                child: Text(
                  "远程协助",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // 内容区：仅 ID + 复制按钮
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Column(
                  children: [
                    // 仅显示 ID（大号、居中）
                    Consumer<ServerModel>(
                      builder: (context, model, child) {
                        final id = model.serverId.text;
                        return Text(
                          id.isEmpty ? "--------" : id,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: 1.0,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // 复制按钮（仅复制 ID）
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2F65BA),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 28,
                        ),
                      ),
                      onPressed: () {
                        final id = context.read<ServerModel>().serverId.text;
                        if (id.isNotEmpty) {
                          final cleanId = id.replaceAll(RegExp(r'\s+'), '');
                          Clipboard.setData(ClipboardData(text: cleanId));
                          // 使用原生 SnackBar 替代 showToast
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("已复制")),
                          );
                        }
                      },
                      child: const Text(
                        "复制",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
