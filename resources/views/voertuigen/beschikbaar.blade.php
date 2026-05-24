<x-layout title="Alle beschikbare voertuigen">
    <section class="page-heading">
        <div>
            <h1>Alle beschikbare voertuigen</h1>
            <div class="detail-lines">
                <p>Naam: [{{ $instructeur->VolledigeNaam }}]</p>
                <p>Datum in dienst: [{{ $instructeur->DatumInDienst->format('d-m-Y') }}]</p>
                <p>Aantal sterren: [{{ $instructeur->AantalSterren }}]</p>
            </div>
        </div>
        <a class="button secondary" href="{{ route('instructeurs.voertuigen.index', $instructeur) }}">Terug</a>
    </section>

    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>Type voertuig</th>
                    <th>Type</th>
                    <th>Kenteken</th>
                    <th>Bouwjaar</th>
                    <th>Brandstof</th>
                    <th>Rijbewijscategorie</th>
                    <th>Toevoegen</th>
                    <th>Wijzigen</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($voertuigen as $voertuig)
                    <tr>
                        <td>{{ $voertuig->TypeVoertuig }}</td>
                        <td>{{ $voertuig->Type }}</td>
                        <td>{{ $voertuig->Kenteken }}</td>
                        <td>{{ \Illuminate\Support\Carbon::parse($voertuig->Bouwjaar)->format('d-m-Y') }}</td>
                        <td>{{ $voertuig->Brandstof }}</td>
                        <td>{{ $voertuig->Rijbewijscategorie }}</td>
                        <td>
                            <a class="icon-button add" href="{{ route('instructeurs.voertuigen.edit', [$instructeur, $voertuig->Id]) }}" title="Toevoegen" aria-label="Toevoegen">
                                +
                            </a>
                        </td>
                        <td>
                            <a class="icon-button" href="{{ route('instructeurs.voertuigen.edit', [$instructeur, $voertuig->Id]) }}" title="Wijzigen" aria-label="Wijzigen">
                                &#9998;
                            </a>
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>
</x-layout>
