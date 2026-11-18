import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/api_client.dart';
import '../services/auth_service.dart';
import '../widgets/auth_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password1 = TextEditingController();
  final _password2 = TextEditingController();
  bool _loading = false;
  bool _obscure = true;
  ApiException? _error;

  static final _usernamePattern = RegExp(r'^[\w.@+-]+$');
  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void dispose() {
    for (final c in [_username, _email, _password1, _password2]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final message = await context.read<AuthService>().register(
            username: _username.text.trim(),
            email: _email.text.trim(),
            password1: _password1.text,
            password2: _password2.text,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      // Kembali ke halaman login dengan username terisi.
      Navigator.of(context).pop(_username.text.trim());
    } on ApiException catch (e) {
      setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pesan umum hanya tampil bila tidak ada error per field.
    final generalError =
        _error != null && _error!.fieldErrors.keys.every((k) => k == 'non_field_errors')
            ? _error!.message
            : null;
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Akun')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Buat akun FoodWastey',
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 4),
                    const Text('Setelah mendaftar, kamu bisa langsung masuk.'),
                    const SizedBox(height: 24),
                    ErrorBanner(generalError),
                    TextFormField(
                      controller: _username,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Pilih username kamu',
                        helperText: 'Huruf, angka, atau @ . + - _ (maks. 150 karakter)',
                        prefixIcon: const Icon(Icons.person_outline),
                        errorText: _error?.field('username'),
                      ),
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return 'Username wajib diisi.';
                        if (value.length > 150) return 'Maksimal 150 karakter.';
                        if (!_usernamePattern.hasMatch(value)) {
                          return 'Gunakan huruf, angka, atau @ . + - _';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'nama@email.com',
                        prefixIcon: const Icon(Icons.mail_outline),
                        errorText: _error?.field('email'),
                      ),
                      validator: (v) => _emailPattern.hasMatch(v?.trim() ?? '')
                          ? null
                          : 'Masukkan alamat email yang valid.',
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _password1,
                      obscureText: _obscure,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        helperText: 'Minimal 8 karakter, jangan hanya angka.',
                        prefixIcon: const Icon(Icons.lock_outline),
                        errorText: _error?.field('password1'),
                        errorMaxLines: 4,
                        suffixIcon: IconButton(
                          tooltip: _obscure ? 'Tampilkan password' : 'Sembunyikan password',
                          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator: (v) =>
                          (v ?? '').length < 8 ? 'Password minimal 8 karakter.' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _password2,
                      obscureText: _obscure,
                      onFieldSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        labelText: 'Konfirmasi password',
                        prefixIcon: const Icon(Icons.lock_reset),
                        errorText: _error?.field('password2'),
                        errorMaxLines: 3,
                      ),
                      validator: (v) =>
                          v != _password1.text ? 'Password tidak sama.' : null,
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: _loading ? null : _submit,
                      child: _loading
                          ? const SizedBox.square(
                              dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('Daftar'),
                    ),
                    TextButton(
                      onPressed: _loading ? null : () => Navigator.of(context).pop(),
                      child: const Text('Sudah punya akun? Masuk'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
