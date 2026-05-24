<x-layout title="Home">
    <section class="hero">
        <div>
            <p class="eyebrow">Dashboard</p>
            <h1>Welkom bij Autorijschool Rijvaardig</h1>
            <p>Beheer instructeurs en voertuigen volgens de MVC-opdracht. Je rol bepaalt welke acties je mag uitvoeren.</p>
            <div class="hero-actions">
                <a class="button" href="{{ route('instructeurs.index') }}">Bekijk instructeurs</a>
                @if (auth()->user()->canManageVehicles())
                    <span class="role-card">Je bent ingelogd als {{ auth()->user()->role }} en mag voertuiggegevens wijzigen.</span>
                @else
                    <span class="role-card">Je bent ingelogd als instructeur en hebt alleen kijkrechten.</span>
                @endif
            </div>
        </div>
    </section>

    <section class="dashboard-grid">
        <article>
            <h2>Instructeurs</h2>
            <p>Bekijk alle instructeurs in dienst, gesorteerd op aantal sterren.</p>
        </article>
        <article>
            <h2>Voertuigen</h2>
            <p>Bekijk toegewezen voertuigen per instructeur en de beschikbare voertuigen.</p>
        </article>
        <article>
            <h2>Rechten</h2>
            <p>Owner en admin hebben volledige toegang. Instructeurs kunnen alleen gegevens bekijken.</p>
        </article>
    </section>
</x-layout>
