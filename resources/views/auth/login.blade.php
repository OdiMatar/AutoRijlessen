<x-layout title="Inloggen">
    <section class="auth-shell">
        <div class="auth-card">
            <p class="eyebrow">Account</p>
            <h1>Inloggen</h1>

            <form method="post" action="{{ route('login.store') }}" class="auth-form">
                @csrf

                <label>
                    E-mailadres
                    <input type="email" name="email" value="{{ old('email') }}" required autofocus>
                    @error('email')<span class="error">{{ $message }}</span>@enderror
                </label>

                <label>
                    Wachtwoord
                    <input type="password" name="password" required>
                    @error('password')<span class="error">{{ $message }}</span>@enderror
                </label>

                <label class="check-line">
                    <input type="checkbox" name="remember" value="1">
                    Onthoud mij
                </label>

                <button class="button" type="submit">Inloggen</button>
            </form>

            <p class="auth-link">Nog geen account? <a href="{{ route('register') }}">Registreren</a></p>
        </div>
    </section>
</x-layout>
