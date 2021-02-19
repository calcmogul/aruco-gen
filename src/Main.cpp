#include <fmt/format.h>
#include <opencv2/aruco.hpp>
#include <opencv2/imgcodecs.hpp>

int main() {
  cv::Mat markerImage;
  cv::Ptr<cv::aruco::Dictionary> dictionary =
      cv::aruco::getPredefinedDictionary(cv::aruco::DICT_6X6_250);
  for (int i = 0; i < 100; ++i) {
      cv::aruco::drawMarker(dictionary, i, 8 * 300, markerImage, 1);
      cv::imwrite(fmt::format("markers/marker{}.png", i), markerImage);
  }
}
