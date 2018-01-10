/**
 * Copyright IBM Corporation 2016, 2018
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import UIKit
import SpeechToTextV1

class MicrophoneBasicViewController: UIViewController {

    var speechToText: SpeechToText!
    var isStreaming = false
    
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        speechToText = SpeechToText(
            username: "7bbe28a5-2ea6-4d38-9826-7cf564a5fe45",
            password: "gRyjSUvbEFCu"
        )
    }
    
    @IBAction func didPressMicrophoneButton(_ sender: UIButton) {
        if !isStreaming {
            isStreaming = true
            microphoneButton.setTitle("Stop Microphone", for: .normal)
            let failure = { (error: Error) in print(error) }
            var settings = RecognitionSettings(contentType: .opus)
            settings.interimResults = true
            speechToText.recognizeMicrophone(settings: settings, failure: failure) { results in
                self.textView.text = results.bestTranscript
            }
        } else {
            isStreaming = false
            microphoneButton.setTitle("Start Microphone", for: .normal)
            speechToText.stopRecognizeMicrophone()
        }
    }
}
