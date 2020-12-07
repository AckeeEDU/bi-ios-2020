//
//  LayoutDiscussionView.swift
//  CVUT-SwiftUI-1
//
//  Created by Jan Kodeš on 05.12.2020.
//

import SwiftUI

struct LayoutDiscussionView: View {
    var body: some View {
        /*

         View mezi sebou komunikují během kalkulace layoutu, aby se zjistila správná velikosti. Konverzace probíhá odshora dolů
         a zároveň od posledního Viewmodifieru konkrétního View směrem nahoru.

         Výsledek je takový, že View dostane nabídku od svého rodiče a následně se rozhodne, jak se vykreslí.
         V podstatě má takovéto možnosti:
         - Vyplnit rodiče
         - Změnšit se na menší velikost a respektovat rodiče
         - Být větši než rodič

         Příklad konverzace:
         1. SwiftUI: Ahoj `LayoutDiscussionView`, celá obrazovka je tvoje. Kolik by sis přálo?
         2. LayoutDiscussionView: Ahoj `Border`, celá obrazovka je tvoje. Kolik by sis přálo?
         3. Border: Ahoj `Background`, celá obrazovka je tvoje. Kolik by sis přálo?
         4. Background: Ahoj `Padding` celá obrazovka je tvoje. Kolik by sis přálo?
         5. Padding(P): Ahoj `HStack`, celá obrazovka je tvoje až na `P` bodů po stranách.
         5. HStack: Hele `Text`, jak jsi velký? 🧐
         6. Texts: Jsem velký přibližně A*B a C*D.

         7. HStack: Potřebuji dostatek prostoru pro svoje potomky tzn. A*B + C*D = E bodů.
         8. Padding: Potřebuji dostatek prostoru pro svoje potomky plus padding po stranách, takže E + P = X bodů.
         9. Background: Budu velký jako moji potomci, tzn. X.
         10. Border: Budu velký jako moji potomci, tzn. X.
         11. LayoutDiscussionView: Budu velký jako moji potomci, tzn. X.
         12: SwiftUI: Dobře, tady máš X.

         */

        HStack {
            Text("Alpacas")
            Text("Rule")
        }
        .padding()
        .background(Color.yellow)
        .border(Color.red)
    }
}

struct LayoutDiscussionView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutDiscussionView()
    }
}
