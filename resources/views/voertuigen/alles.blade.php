<x-layout title="Alle voertuigen">
    <section class="page-heading">
        <div>
            <h1>Alle voertuigen</h1>
        </div>
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
                    <th>Instructeur naam</th>
                    @if (auth()->user()->canManageVehicles())
                        <th>Verwijderen</th>
                    @endif
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
                        <td>{{ $voertuig->InstructeurNaam ?? '-' }}</td>
                        @if (auth()->user()->canManageVehicles())
                            <td>
                                <form method="post" action="{{ route('voertuigen.destroy', $voertuig->Id) }}">
                                    @csrf
                                    @method('DELETE')
                                    <button class="icon-button danger" type="submit" title="Verwijderen" aria-label="Verwijderen">x</button>
                                </form>
                            </td>
                        @endif
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>
</x-layout>
