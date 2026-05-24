<!doctype html>
<html lang="nl">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ $title ?? 'Autorijschool' }}</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body>
    <header class="topbar">
        <a href="{{ auth()->check() ? route('home') : route('login') }}" class="brand">Autorijschool Rijvaardig</a>
        <nav>
            @auth
                <a href="{{ route('home') }}">Home</a>
                <a href="{{ route('instructeurs.index') }}">Instructeurs</a>
                <span class="user-pill">{{ auth()->user()->name }} - {{ ucfirst(auth()->user()->role) }}</span>
                <form method="post" action="{{ route('logout') }}">
                    @csrf
                    <button type="submit" class="link-button">Uitloggen</button>
                </form>
            @else
                <a href="{{ route('login') }}">Inloggen</a>
                <a href="{{ route('register') }}">Registreren</a>
            @endauth
        </nav>
    </header>

    <main class="page">
        @if (session('success'))
            <div class="alert">{{ session('success') }}</div>
        @endif

        {{ $slot }}
    </main>
</body>
</html>
