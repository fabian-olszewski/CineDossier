//
//  PreviewSupport.swift
//  CineDossier
//
//  Created by Fabian Olszewski on 10/08/2026.
//

#if DEBUG
extension Genre {
    static var sample: Genre { samples.randomElement()! }
    
    static let samples: [Genre] = [
        Genre(id: 28, name: "Action"),
        Genre(id: 12, name: "Adventure"),
        Genre(id: 16, name: "Animation"),
        Genre(id: 35, name: "Comedy"),
        Genre(id: 80, name: "Crime"),
        Genre(id: 99, name: "Documentary"),
        Genre(id: 18, name: "Drama"),
        Genre(id: 10751, name: "Family"),
        Genre(id: 14, name: "Fantasy"),
        Genre(id: 36, name: "History"),
        Genre(id: 27, name: "Horror"),
        Genre(id: 10402, name: "Music"),
        Genre(id: 9648, name: "Mystery"),
        Genre(id: 10749, name: "Romance"),
        Genre(id: 878, name: "Science Fiction"),
        Genre(id: 10770, name: "TV Movie"),
        Genre(id: 53, name: "Thriller"),
        Genre(id: 10752, name: "War"),
        Genre(id: 37, name: "Western"),
    ]
}

extension Movie {
    static var sample: Movie { samples.randomElement()! }
    
    static let samples: [Movie] = [
        Movie(id: 934433, title: "Scream VI", overview: "Following the latest Ghostface killings, the four survivors leave Woodsboro behind and start a fresh chapter.", posterPath: "/wDWwtvkRRlgTiUr6TyLSMX8FCuZ.jpg", voteAverage: 7.374),

        Movie(id: 868759, title: "Ghosted", overview: "Salt-of-the-earth Cole falls head over heels for enigmatic Sadie — but then makes the shocking discovery that she's a secret agent. Before they can decide on a second date, Cole and Sadie are swept away on an international adventure to save the world.", posterPath: "/liLN69YgoovHVgmlHJ876PKi5Yi.jpg", voteAverage: 7.318),

        Movie(id: 502356, title: "The Super Mario Bros. Movie", overview: "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.", posterPath: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg", voteAverage: 7.51),

        Movie(id: 640146, title: "Ant-Man and the Wasp: Quantumania", overview: "Super-Hero partners Scott Lang and Hope van Dyne, along with with Hope's parents Janet van Dyne and Hank Pym, and Scott's daughter Cassie Lang, find themselves exploring the Quantum Realm, interacting with strange new creatures and embarking on an adventure that will push them beyond the limits of what they thought possible.", posterPath: "/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg", voteAverage: 6.526),

        Movie(id: 713704, title: "Evil Dead Rise", overview: "Two sisters find an ancient vinyl that gives birth to bloodthirsty demons that run amok in a Los Angeles apartment building and thrusts them into a primal battle for survival as they face the most nightmarish version of family imaginable.", posterPath: "/mIBCtPvKZQlxubxKMeViO2UrP3q.jpg", voteAverage: 6.965),

        Movie(id: 298618, title: "The Flash", overview: "When his attempt to save his family inadvertently alters the future, Barry Allen becomes trapped in a reality in which General Zod has returned and there are no Super Heroes to turn to. In order to save the world that he is in and return to the future that he knows, Barry's only hope is to race for his life. But will making the ultimate sacrifice be enough to reset the universe?", posterPath: "/5aZoKcR8VxYWhiENYOUg6ooGbc8.jpg", voteAverage: 0),

        Movie(id: 447365, title: "Guardians of the Galaxy Volume 3", overview: "Peter Quill, still reeling from the loss of Gamora, must rally his team around him to defend the universe along with protecting one of their own. A mission that, if not completed successfully, could quite possibly lead to the end of the Guardians as we know them.", posterPath: "/r2J02Z2OpNTctfOSN1Ydgii51I3.jpg", voteAverage: 0),

        Movie(id: 76600, title: "Avatar: The Way of Water", overview: "Set more than a decade after the events of the first film, learn the story of the Sully family (Jake, Neytiri, and their kids), the trouble that follows them, the lengths they go to keep each other safe, the battles they fight to stay alive, and the tragedies they endure.", posterPath: "/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg", voteAverage: 7.7),

        Movie(id: 873256, title: "Kiss, Kiss!", overview: "Convinced he can charm any woman, a tenacious flirt sets his sights on a headstrong bride-to-be engaged to the son of an ambitious politician.", posterPath: "/jLn0dg0n73v8L6lKkTkX5k8POyy.jpg", voteAverage: 7.25),

        Movie(id: 594767, title: "Shazam! Fury of the Gods", overview: "Billy Batson and his foster siblings, who transform into superheroes by saying \"Shazam!\", are forced to get back into action and fight the Daughters of Atlas, who they must stop from using a weapon that could destroy the world.", posterPath: "/2VK4d3mqqTc7LVZLnLPeRiPaJ71.jpg", voteAverage: 6.848),

        Movie(id: 700391, title: "65", overview: "65 million years ago, the only 2 survivors of a spaceship from Somaris that crash-landed on Earth must fend off dinosaurs and reach the escape vessel in time before an imminent asteroid strike threatens to destroy the planet.", posterPath: "/rzRb63TldOKdKydCvWJM8B6EkPM.jpg", voteAverage: 6.3),

        Movie(id: 603692, title: "John Wick: Chapter 4", overview: "With the price on his head ever increasing, John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.", posterPath: "/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg", voteAverage: 7.975),

        Movie(id: 447277, title: "The Little Mermaid", overview: "The youngest of King Triton's daughters, and the most defiant, Ariel longs to find out more about the world beyond the sea, and while visiting the surface, falls for the dashing Prince Eric. With mermaids forbidden to interact with humans, Ariel makes a deal with the evil sea witch, Ursula, which gives her a chance to experience life on land, but ultimately places her life – and her father's crown – in jeopardy.", posterPath: "/ym1dxyOk4jFcSl4Q2zmRrA5BEEN.jpg", voteAverage: 0),

        Movie(id: 667538, title: "Transformers: Rise of the Beasts", overview: "A '90s globetrotting adventure that introduces the Maximals, Predacons, and Terrorcons to the existing battle on earth between Autobots and Decepticons.", posterPath: "/g1HcrEiN0UiSpjQMJ3Klzw8KOZS.jpg", voteAverage: 0),

        Movie(id: 646385, title: "Scream", overview: "Twenty-five years after a streak of brutal murders shocked the quiet town of Woodsboro, a new killer has donned the Ghostface mask and begins targeting a group of teenagers to resurrect secrets from the town's deadly past.", posterPath: "/4qIV5WXP1xQvpPAHmgVxCmxvPh6.jpg", voteAverage: 6.737),

        Movie(id: 997776, title: "Justice League x RWBY: Super Heroes & Huntsmen, Part One", overview: "Superman, Batman, Wonder Woman, Flash, Cyborg, Green Lantern and Vixen are transported to the strange world of Remnant and find themselves turned into teenagers. Meanwhile, Remnant heroes Ruby, Weiss, Blake and Yang must combine forces with the Justice League to uncover why their planet has been mysteriously altered before a superpowered Grimm destroys everything.", posterPath: "/sjBFnG8DpouuWi161KbjbAER235.jpg", voteAverage: 8.238),

        Movie(id: 813726, title: "A Tourist's Guide to Love", overview: "After an unexpected break up, a travel executive accepts an assignment to go undercover and learn about the tourist industry in Vietnam. Along the way, she finds adventure and romance with her Vietnamese expat tour guide and they decide to hijack the tour bus in order to explore life and love off the beaten path.", posterPath: "/uWkpjbBe4gRZilXRXbYfsMUZMhz.jpg", voteAverage: 6.603),

        Movie(id: 1068141, title: "Mighty Morphin Power Rangers: Once & Always", overview: "After tragedy strikes, an unlikely young hero takes her rightful place among the Power Rangers to face off against the team's oldest archnemesis.", posterPath: "/vc87upO8vcAGj9OmgH3AIz6ikKB.jpg", voteAverage: 6.931),

        Movie(id: 536554, title: "M3GAN", overview: "A brilliant toy company roboticist uses artificial intelligence to develop M3GAN, a life-like doll programmed to emotionally bond with her newly orphaned niece. But when the doll's programming works too well, she becomes overprotective of her new friend with terrifying results.", posterPath: "/d9nBoowhjiiYc4FBNtQkPY7c11H.jpg", voteAverage: 7.367),

        Movie(id: 944152, title: "Chokehold", overview: "Evading a scandal, a couple from Istanbul starts over in a town on the Aegean coast — but quickly discover the locals are determined to get rid of them.", posterPath: "/bW7NgAKpP24skkTjmJxNYWjOwdj.jpg", voteAverage: 5.6),
    ]
}
#endif
