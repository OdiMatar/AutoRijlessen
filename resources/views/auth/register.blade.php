<x-layout title="Registreren">
    <section class="auth-shell">
        <div class="auth-card">
            <p class="eyebrow">Nieuw account</p>
            <h1>Registreren</h1>

            <form method="post" action="{{ route('register.store') }}" class="auth-form">
                @csrf

                <label>
                    Naam
                    <input name="name" value="{{ old('name') }}" required autofocus>
                    @error('name')<span class="error">{{ $message }}</span>@enderror
                </label>

                <label>
                    E-mailadres
                    <input type="email" name="email" value="{{ old('email') }}" required>
                    @error('email')<span class="error">{{ $message }}</span>@enderror
                </label>

                <label>
                    Rol
                    <select name="role" required>
                        @foreach ($roles as $value => $label)
                            <option value="{{ $value }}" @selected(old('role', 'instructeur') === $value)>{{ $label }}</option>
                        @endforeach
                    </select>
                    @error('role')<span class="error">{{ $message }}</span>@enderror
                </label>

                <label>
                    Wachtwoord
                    <input type="password" name="password" required>
                    @error('password')<span class="error">{{ $message }}</span>@enderror
                </label>

                <label>
                    Herhaal wachtwoord
                    <input type="password" name="password_confirmation" required>
                </label>

                <button class="button" type="submit">Registreren</button>
            </form>

            <p class="auth-link">Heb je al een account? <a href="{{ route('login') }}">Inloggen</a></p>
        </div>
    </section>
</x-layout>
