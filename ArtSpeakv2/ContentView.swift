import SwiftUI
import AVFoundation
import Vision
import CoreML

struct Artwork: Identifiable {
    let id: Int
    let name: String
    let imageName: String
    let description: String
}

struct ContentView: View {
    @State private var synthesizer = AVSpeechSynthesizer()
    @State private var isShowingCamera = false
    @State private var selectedRoom: Int?
    @State private var descriptionVisibility: [Bool] = Array(repeating: false, count: 18)
    @State private var capturedImages: [UIImage] = []
    @State private var isBookmarkClicked = false

    let artworks: [Artwork] = [
       Artwork(id: 1, name: "Bridge Over A Pond Of Waterlilllies by Claude Monet", imageName: "art1_1", description: "The painting depicts a small pond surrounded by lush greenery, with water lilies floating gracefully on the surface. The water lilies are the main focal point of the painting, with their delicate white petals with flecks of pink and red creating a stunning contrast against the calm waters of the pond. The leaves of the lilies are a deep green, and they stretch out towards the center of the pond, creating intricate patterns and shapes that reflect the light and shadow play on the water's surface. There are also rays of sunlight peeking through the foliage creating a lovely warm contrast of yellow and green. The reflection of this can be seen in the calm, clear water of the pond. In the background, there is a small wooden footbridge that spans the width of the pond, partially obscured by the lush foliage of the water lilies and the weeping willows that surround the pond. The bridge adds a touch of human presence to the otherwise natural setting, suggesting a quiet, secluded spot where one might pause to take in the beauty of nature. The colors used in the painting are soft and muted, with a focus on blues, greens, and purples that evoke a sense of calmness and serenity. The brushwork is loose and feathery, with visible strokes that give the painting a sense of texture and depth. The overall effect is one of peacefulness and tranquility, inviting the viewer to experience the idyllic beauty of a summer day in France."),
        Artwork(id: 2, name: "The North Cape by Moonlight by Peder Balke", imageName: "art2_1", description: "In the painting The North Cape by Moonlight by Peder Balke, the foreground is dominated by rocky cliffs, their jagged edges suggesting a formidable presence against the icy waters below. The artist's brushstrokes meticulously depict the texture of these rocks, conveying a sense of their rough, weathered surface.The color palette is dominated by deep blues and purples, mirroring the nighttime sky illuminated by the soft, silvery glow of the moon. This gentle light casts a tranquil aura over the landscape, revealing hints of white from the snow-capped peaks in the distance.The sea below appears to sway with the rhythm of the waves, rendered with subtle textures and shades that evoke a sense of movement. Despite the absence of human figures, there's a palpable feeling of solitude in the vastness of the scene, as if the viewer stands alone at the edge of the world. Yet, amidst this solitude, there's also a sense of awe and wonder. The North Cape, a symbol of exploration and adventure, is captured in all its grandeur, inviting the viewer to embark on a journey into the unknown. Through Balke's skillful use of color, texture, and composition, the painting transcends mere representation, immersing the viewer in a world of quiet contemplation and boundless possibility."),
                Artwork(id: 3, name: "View over Hallindal by Johan Christian Dahl", imageName: "art2_2", description: "In Johan Christian Dahl's View over Hallingdal, the canvas is a symphony of greens and blues, echoing the tranquil beauty of the Norwegian landscape. In the foreground, the valley unfolds with soft, undulating slopes, painted in vibrant shades of green that speak of life and growth. The forests sway gently in the breeze, their leaves rustling with the whispers of centuries past. Above, the sky stretches out in a vast expanse of azure, dotted with fluffy clouds that drift lazily across the horizon. The colors blend seamlessly, creating a sense of infinite space that stretches on into eternity. In the distance, the mountains rise majestically, their peaks shrouded in mist that lends an air of mystery to the scene. Dahl's brushwork is meticulous, capturing every nuance of light and shadow with precision. The play of sunlight on the valley floor creates a sense of depth and dimension, while the subtle shifts in color evoke the changing seasons. There's a palpable sense of peace and serenity in the painting, as if time itself has come to a standstill, allowing the viewer to bask in the beauty of the moment. But beneath the surface tranquility, there's a hint of melancholy, a reminder of the impermanence of all things. The passing of time is evident in the changing hues of the landscape, from the verdant greens of spring to the golden hues of autumn. Yet, there's also a sense of hope, a recognition of the enduring beauty that lies at the heart of the natural world. In View over Hallingdal, Johan Christian Dahl invites the viewer to immerse themselves in the quiet majesty of the Norwegian countryside, to lose themselves in its timeless beauty and to find solace in the ever-changing rhythms of nature."),
                Artwork(id: 4, name: "Two Men Before a Waterfall at Sunset by Johan Christian Dahl", imageName: "art2_3", description: "In Johan Christian Dahl's Two Men Before a Waterfall at Sunset, the canvas is alive with the vibrant hues of twilight, painting a scene of awe-inspiring beauty. In the foreground, two figures stand silhouetted against the cascading waters, their forms rendered in dark, shadowy tones that contrast sharply with the fiery glow of the setting sun. The waterfall itself is a marvel to behold, its waters tumbling down with a mesmerizing energy that seems to echo the rhythm of life itself. Dahl's brushwork is masterful, capturing the movement of the water with fluid strokes that shimmer and dance in the fading light. Above, the sky is ablaze with color, a riot of oranges, pinks, and purples that stretch out across the horizon like a canvas on fire. The last rays of sunlight cast a golden glow over the scene, illuminating the mist rising from the waterfall and infusing the air with a sense of magic and wonder. There's a sense of awe and reverence in the painting, as if the two figures stand in silent contemplation of the natural world unfolding before them. The waterfall, with its raw power and untamed beauty, serves as a reminder of the sublime forces that shape our world and our lives. But amidst the grandeur of the landscape, there's also an intimacy to the scene, a sense of connection between the two men and the world around them. It's as if they are not merely observers, but participants in the timeless dance of nature, finding solace and inspiration in its ever-changing beauty. In Two Men Before a Waterfall at Sunset, Johan Christian Dahl invites the viewer to join these two figures on their journey of discovery, to witness the fleeting beauty of a sunset reflected in the waters of a cascading waterfall, and to find peace and wonder in the majesty of the natural world."),
                Artwork(id: 5, name: "Artwork 4", imageName: "art2_4", description: "Description of Artwork 5..."),
                Artwork(id: 6, name: "Artwork 5", imageName: "art2_5", description: "Description of Artwork 6..."),
                Artwork(id: 7, name: "Artwork 6", imageName: "art2_6", description: "Description of Artwork 7..."),
                Artwork(id: 8, name: "Artwork 7", imageName: "art2_7", description: "Description of Artwork 8..."),
                Artwork(id: 9, name: "Artwork 8", imageName: "art2_8", description: "Description of Artwork 9..."),
                Artwork(id: 10, name: "Artwork 9", imageName: "art2_9", description: "Description of Artwork 10..."),
                Artwork(id: 11, name: "Artwork 10", imageName: "art2_10", description: "Description of Artwork 11..."),
                Artwork(id: 12, name: "Artwork 11", imageName: "art2_11", description: "Description of Artwork 12..."),
                Artwork(id: 13, name: "Artwork 12", imageName: "art2_12", description: "Description of Artwork 13..."),
                Artwork(id: 14, name: "Artwork 13", imageName: "art2_13", description: "Description of Artwork 14..."),
                Artwork(id: 15, name: "Artwork 14", imageName: "art2_14", description: "Description of Artwork 15..."),
                Artwork(id: 16, name: "Artwork 15", imageName: "art2_15", description: "Description of Artwork 16..."),
                Artwork(id: 17, name: "Artwork 16", imageName: "art2_16", description: "Description of Artwork 16...")
        // Add more artwork data as needed
    ]


    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(alignment: .center) {
                    Spacer()
                    Spacer()
                    Text("Art")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                        .foregroundColor(.white)

                    Text("Speak")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                        .foregroundColor(.white)

                    Spacer()

                    Image(systemName: "bell")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                        .padding()
                }
                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                .foregroundColor(.white)

                ScrollView {
                    VStack(spacing: 20) {
                        HStack {
                            Button("Room 1") {
                                selectedRoom = 1
                            }
                            .foregroundColor(.black)
                            .padding()
                            .background(selectedRoom == 1 ? Color.red : Color(red: 0.95, green: 0.95, blue: 0.95))
                            .cornerRadius(8)
                            .padding(.horizontal)

                            Button("Room 2") {
                                selectedRoom = 2
                            }
                            .foregroundColor(.black)
                            .padding()
                            .background(selectedRoom == 2 ? Color.red : Color(red: 0.95, green: 0.95, blue: 0.95))
                            .cornerRadius(8)
                            .padding(.horizontal)
                        }

                        if let selectedRoom = selectedRoom {
                            let filteredArtworks = selectedRoom == 1 ? artworks.filter { $0.id == 1 } : artworks.filter { $0.id != 1 }
                            ForEach(filteredArtworks) { artwork in
                                RoomContent(artwork: artwork, isDescriptionVisible: self.$descriptionVisibility[artwork.id], synthesizer: self.synthesizer)
                                    .padding(.bottom, 20)
                            }
                        }
                    }
                    .padding()
                }
            }.padding(.bottom, 50)
            .background(.white)

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: Text("Home")) {
                        Image(systemName: "house")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                    Spacer()
                    NavigationLink(destination: Text("Search")) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                            .padding()
                    }
                    Spacer()
                    Button(action: {
                        self.isShowingCamera.toggle()
                    }) {
                        Image(systemName: "camera")
                            .foregroundColor(.black)
                            .padding()
                    }
                    .sheet(isPresented: $isShowingCamera) {
                        ImagePickerView(sourceType: .camera) { image in
                            if let image = image {
                                capturedImages.append(image)
                            }
                        }
                    }
                    Spacer()
                    Button(action: {
                        isBookmarkClicked.toggle()
                    }) {
                        Image(systemName: "bookmark")
                            .foregroundColor(isBookmarkClicked ? .white : .black)
                            .padding()
                            .background(isBookmarkClicked ? Color.red : Color.clear)
                    }
                    Spacer()
                }
                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                .padding(.vertical)
            }.edgesIgnoringSafeArea(.bottom)
        }
        .sheet(isPresented: $isBookmarkClicked) {
            if capturedImages.isEmpty {
                Text("No images found")
            } else {
                BookmarksView(images: capturedImages)
            }
        }
    }
}

struct RoomContent: View {
    var artwork: Artwork
    @Binding var isDescriptionVisible: Bool
    let synthesizer: AVSpeechSynthesizer

    var body: some View {
        VStack(spacing: 20) {
            Text(artwork.name)
                .font(.largeTitle)
                .foregroundColor(Color.black)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            Image(artwork.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .padding()

            ButtonRow(isDescriptionVisible: $isDescriptionVisible, artwork: artwork, synthesizer: synthesizer)
            if isDescriptionVisible {
                Text(artwork.description)
                    .padding().foregroundColor(Color.black).background(Color(red: 1.0, green: 0.96, blue: 0.86))
                    .cornerRadius(8)
            }
        }
    }
}

struct ButtonRow: View {
    @Binding var isDescriptionVisible: Bool
    var artwork: Artwork
    let synthesizer: AVSpeechSynthesizer
    @State private var isPlayingAudio = false

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                isDescriptionVisible.toggle()
            }) {
                if isDescriptionVisible {
                    Text("Close Description")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(8)
                } else {
                    Text("View Description")
                        .padding()
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
            }
            Spacer()
            Button(action: {
                if isPlayingAudio {
                    synthesizer.stopSpeaking(at: .immediate)
                    isPlayingAudio = false
                } else {
                    speakArtworkDescription(artwork)
                    isPlayingAudio = true
                }
            }) {
                if isPlayingAudio {
                    Text("Stop Audio")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(8)
                } else {
                    Text("Listen Audio")
                        .padding()
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
            }
            Spacer()
        }
    }

    private func speakArtworkDescription(_ artwork: Artwork) {
        let utterance = AVSpeechUtterance(string: artwork.description)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(utterance)
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    var completionHandler: (UIImage?) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerView

        init(_ parent: ImagePickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else {
                parent.completionHandler(nil)
                return
            }
            parent.completionHandler(image)
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

struct BookmarksView: View {
    var images: [UIImage]

    @State private var selectedImageIndex: Int?
    @State private var visualLookupResults: [String?] = Array(repeating: nil, count: 10)
    @State private var isVisualLookupInProgress = Array(repeating: false, count: 10)
    @State private var modelLoadingError: String?

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(images.indices, id: \.self) { index in
                    VStack {
                        Image(uiImage: images[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                            .onTapGesture {
                                selectedImageIndex = index
                                performVisualLookup(for: images[index], index: index)
                            }
                    }
                    .background(Color.white)
                    .popover(isPresented: Binding<Bool>(
                        get: { selectedImageIndex == index },
                        set: { _ in selectedImageIndex = nil }
                    )) {
                        VStack {
                            if let error = modelLoadingError {
                                Text("Model Loading Error: \(error)")
                                    .padding()
                                    .foregroundColor(.red)
                            } else {
                                Text("Description")
                                    .font(.headline)
                                    .padding()
                                if let result = visualLookupResults[index], !isVisualLookupInProgress[index] {
                                    Text(result)
                                        .padding()
                                        .foregroundColor(.black)
                                } else if isVisualLookupInProgress[index] {
                                    ProgressView()
                                        .padding()
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(8)
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
        .onAppear {
            loadModel()
        }
    }

    private func loadModel() {
        do {
            let modelConfiguration = MLModelConfiguration()
            let model = try VNCoreMLModel(for: YOLOv3Tiny(configuration: modelConfiguration).model)
            // Store the loaded model for later use
        } catch {
            print("Error loading model:", error)
            modelLoadingError = error.localizedDescription
        }
    }

    private func performVisualLookup(for image: UIImage, index: Int) {
        let modelConfiguration = MLModelConfiguration()
        guard let model = try? VNCoreMLModel(for: YOLOv3Tiny(configuration: modelConfiguration).model) else {
                print("Error: Failed to load object detection model")
                return
            }

            guard let cgImage = image.cgImage else {
                print("Error: Failed to convert UIImage to CGImage")
                return
            }

            let request = VNCoreMLRequest(model: model) { (request, error) in
                guard error == nil else {
                    print("Error performing object detection:", error!)
                    visualLookupResults[index] = "Error: \(error!.localizedDescription)"
                    isVisualLookupInProgress[index] = false
                    return
                }

                guard let results = request.results as? [VNClassificationObservation], let firstResult = results.first else {
                    visualLookupResults[index] = "No objects found"
                    isVisualLookupInProgress[index] = false
                    return
                }

                visualLookupResults[index] = "\(firstResult.identifier) - Confidence: \(firstResult.confidence)"
                isVisualLookupInProgress[index] = false
            }

            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try handler.perform([request])
                isVisualLookupInProgress[index] = true
            } catch {
                print("Error: Failed to perform object detection:", error)
                isVisualLookupInProgress[index] = false
            }
    }
}

    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    

