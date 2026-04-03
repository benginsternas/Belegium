// Copyright (c) 2026 Bengin Sternas.
//
// Project: Belegium
// This project is licensed under the Apache License 2.0.
// See the LICENSE file in the root directory for details.

import 'package:flutter/material.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_selector/file_selector.dart';
import '../core/parsers/excel_parser.dart';
import '../core/generators/pdf_generator.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedFilePath;
  bool _isDragging = false;
  bool _isProcessing = false;

  Future<void> _selectFile() async {
    const typeGroup = XTypeGroup(
      label: 'Excel files',
      extensions: ['xlsx', 'xls'],
    );
    final file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file != null) {
      setState(() {
        _selectedFilePath = file.path;
      });
    }
  }

  Future<void> _processFile() async {
    if (_selectedFilePath == null) return;
    
    final directoryPath = await getDirectoryPath();
    if (directoryPath == null) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final models = await ExcelParser.parse(_selectedFilePath!);
      await PdfGenerator.generateAndSave(models, directoryPath);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erfolgreich: ${models.length} Kassenanordnungen erstellt.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Verarbeiten: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belegium', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              DropTarget(
                onDragDone: (detail) {
                  if (detail.files.isNotEmpty) {
                    setState(() {
                      _selectedFilePath = detail.files.first.path;
                    });
                  }
                },
                onDragEntered: (detail) {
                  setState(() {
                    _isDragging = true;
                  });
                },
                onDragExited: (detail) {
                  setState(() {
                    _isDragging = false;
                  });
                },
                child: Container(
                  width: 600,
                  height: 300,
                  decoration: BoxDecoration(
                    color: _isDragging 
                        ? theme.colorScheme.primaryContainer.withOpacity(0.5)
                        : theme.colorScheme.surface,
                    border: Border.all(
                      color: _isDragging 
                          ? theme.colorScheme.primary 
                          : theme.colorScheme.outline,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upload_file,
                        size: 64,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _selectedFilePath == null
                            ? 'Excel-Datei hierhin ziehen'
                            : 'Ausgewählt: ${_selectedFilePath!.split(Platform.pathSeparator).last}',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: _selectFile,
                        icon: const Icon(Icons.folder_open),
                        label: const Text('Datei auswählen'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 56,
                width: 300,
                child: FilledButton.icon(
                  onPressed: (_selectedFilePath == null || _isProcessing) ? null : _processFile,
                  icon: _isProcessing 
                      ? const SizedBox(
                          width: 24, 
                          height: 24, 
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.picture_as_pdf),
                  label: Text(
                    _isProcessing ? 'Wird erstellt...' : 'Kassenanordnungen erstellen',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
