<x-layout title="Home">
    <section class="hero">
        <div>
            <p class="eyebrow">Dashboard</p>
            <h1>Welkom bij Autorijschool De Komeet</h1>
            <p>Beheer instructeurs en voertuigen volgens de MVC-opdracht. Je rol bepaalt welke acties je mag uitvoeren.</p>
            <div class="hero-actions">
                <a class="button" href="{{ route('instructeurs.index') }}">Instructeurs in dienst</a>
                <a class="button secondary" href="{{ route('voertuigen.alles') }}">Alle voertuigen</a>
                @if (auth()->user()->canManageVehicles())
                    <span class="role-card">Je bent ingelogd als {{ auth()->user()->role }} en mag voertuiggegevens wijzigen.</span>
                @else
                    <span class="role-card">Je bent ingelogd als instructeur en hebt alleen kijkrechten.</span>
                @endif
            </div>
        </div>
    </section>

    <section class="dashboard-grid">
        <a class="dashboard-card" href="{{ route('instructeurs.index') }}">
            <span class="card-kicker">01</span>
            <h2>Instructeurs</h2>
            <p>Bekijk alle instructeurs in dienst, gesorteerd op aantal sterren.</p>
        </a>
        <a class="dashboard-card" href="{{ route('voertuigen.alles') }}">
            <span class="card-kicker">02</span>
            <h2>Voertuigen</h2>
            <p>Bekijk toegewezen voertuigen per instructeur, beschikbare voertuigen en alle voertuigen.</p>
        </a>
        <article class="dashboard-card">
            <span class="card-kicker">03</span>
            <h2>Rechten</h2>
            <p>Owner en admin hebben volledige toegang. Instructeurs kunnen alleen gegevens bekijken.</p>
        </article>
    </section>
</x-layout>
